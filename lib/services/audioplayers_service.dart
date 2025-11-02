import 'package:audioplayers/audioplayers.dart';

final class AudioplayersService {
  // ---- Singleton ----
  static final AudioplayersService _instance = AudioplayersService._internal();
  factory AudioplayersService() => _instance;
  AudioplayersService._internal();

  // ---- Players ----
  final AudioPlayer _bgmPlayer = AudioPlayer(); // background music
  late final List<AudioPlayer> _sfxPlayers; // SFX pool
  int _sfxIndex = 0;

  // ---- Config ----
  final int _sfxPoolSize = 4; // allow up to 4 overlapping SFX
  bool _initialized = false;

  /// Call once (e.g., in main()).
  /// Optionally pass assets to preload so the first play feels snappy.
  Future<void> init({
    List<String> preloadSfxAssets = const [],
    String? preloadBgmAsset,
  }) async {
    if (_initialized) return;

    // BGM loops by default
    await _bgmPlayer.setReleaseMode(ReleaseMode.loop);

    // Build SFX pool
    _sfxPlayers = List.generate(_sfxPoolSize, (_) => AudioPlayer());

    // "Warm up" decoders by setting sources ahead of time (optional but nice)
    for (final asset in preloadSfxAssets) {
      final p = _nextSfxPlayer();
      await p.setSource(AssetsSource(asset));
      await p.stop();
    }
    if (preloadBgmAsset != null) {
      await _bgmPlayer.setSource(AssetsSource(preloadBgmAsset));
      await _bgmPlayer.stop();
    }

    _initialized = true;
  }

  // ----------------- Background Music -----------------

  /// Play background music. Pass an asset path like 'assets/audio/bg_music.mp3'.
  Future<void> playBgm(
    String assetPath, {
    double volume = 1.0,
    bool loop = true,
  }) async {
    await _bgmPlayer.setVolume(volume.clamp(0.0, 1.0));
    await _bgmPlayer.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
    await _bgmPlayer.play(AssetsSource(assetPath));
  }

  Future<void> pauseBgm() => _bgmPlayer.pause();
  Future<void> resumeBgm() => _bgmPlayer.resume();
  Future<void> stopBgm() => _bgmPlayer.stop();

  Future<void> setBgmVolume(double volume) =>
      _bgmPlayer.setVolume(volume.clamp(0.0, 1.0));

  // ----------------- Sound Effects -----------------

  /// Play a short sound effect from assets.
  /// Example: 'assets/audio/click.wav'
  Future<void> playSfx(
    String assetPath, {
    double volume = 1.0,
  }) async {
    final p = _nextSfxPlayer();
    await p.setVolume(volume.clamp(0.0, 1.0));
    await p.play(AssetsSource(assetPath));
  }

  // ----------------- Lifecycle -----------------

  /// Stop everything and free resources (e.g., on app shutdown).
  Future<void> dispose() async {
    await _bgmPlayer.dispose();
    for (final p in _sfxPlayers) {
      await p.dispose();
    }
    _initialized = false;
  }

  // ----------------- Helpers -----------------

  AudioPlayer _nextSfxPlayer() {
    if (_sfxPlayers.isEmpty) {
      // Fallback safety (init not called) — create one on the fly.
      _sfxPlayers = [AudioPlayer()];
    }
    final p = _sfxPlayers[_sfxIndex % _sfxPlayers.length];
    _sfxIndex++;
    return p;
  }
}

class AssetsSource extends Source {
  final String path;

  @override
  final String? mimeType;

  AssetsSource(this.path, {this.mimeType});

  @override
  Future<void> setOnPlayer(AudioPlayer player) {
    return player.setSourceAsset(path.replaceAll('assets/', ''), mimeType: mimeType);
  }

  @override
  String toString() {
    return 'AssetsSource(path: $path, mimeType: $mimeType)';
  }
}
