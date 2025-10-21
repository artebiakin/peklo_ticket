// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsImageGen {
  const $AssetsImageGen();

  /// File path: assets/image/1. Start screen with clip.png
  AssetGenImage get a1StartScreenWithClip =>
      const AssetGenImage('assets/image/1. Start screen with clip.png');

  /// File path: assets/image/1. Start screen.png
  AssetGenImage get a1StartScreen =>
      const AssetGenImage('assets/image/1. Start screen.png');

  /// File path: assets/image/avatar_1.png
  AssetGenImage get avatar1 => const AssetGenImage('assets/image/avatar_1.png');

  /// File path: assets/image/avatar_2.png
  AssetGenImage get avatar2 => const AssetGenImage('assets/image/avatar_2.png');

  /// File path: assets/image/avatar_3.png
  AssetGenImage get avatar3 => const AssetGenImage('assets/image/avatar_3.png');

  /// File path: assets/image/avatar_4.png
  AssetGenImage get avatar4 => const AssetGenImage('assets/image/avatar_4.png');

  /// File path: assets/image/avatar_5.png
  AssetGenImage get avatar5 => const AssetGenImage('assets/image/avatar_5.png');

  /// File path: assets/image/avatar_6.png
  AssetGenImage get avatar6 => const AssetGenImage('assets/image/avatar_6.png');

  /// File path: assets/image/avatar_7.png
  AssetGenImage get avatar7 => const AssetGenImage('assets/image/avatar_7.png');

  /// File path: assets/image/avatar_8.png
  AssetGenImage get avatar8 => const AssetGenImage('assets/image/avatar_8.png');

  /// File path: assets/image/button_next.png
  AssetGenImage get buttonNext =>
      const AssetGenImage('assets/image/button_next.png');

  /// File path: assets/image/cart.png
  AssetGenImage get cart => const AssetGenImage('assets/image/cart.png');

  /// File path: assets/image/coin.png
  AssetGenImage get coin => const AssetGenImage('assets/image/coin.png');

  /// File path: assets/image/form_bg.png
  AssetGenImage get formBg => const AssetGenImage('assets/image/form_bg.png');

  /// File path: assets/image/hair.png
  AssetGenImage get hair => const AssetGenImage('assets/image/hair.png');

  /// File path: assets/image/login_done.png
  AssetGenImage get loginDone =>
      const AssetGenImage('assets/image/login_done.png');

  /// File path: assets/image/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/image/logo.png');

  /// File path: assets/image/morpheus.png
  AssetGenImage get morpheus =>
      const AssetGenImage('assets/image/morpheus.png');

  /// File path: assets/image/password_bg.png
  AssetGenImage get passwordBg =>
      const AssetGenImage('assets/image/password_bg.png');

  /// File path: assets/image/rug.png
  AssetGenImage get rug => const AssetGenImage('assets/image/rug.png');

  /// File path: assets/image/support.png
  AssetGenImage get support => const AssetGenImage('assets/image/support.png');

  /// File path: assets/image/ticket.png
  AssetGenImage get ticket => const AssetGenImage('assets/image/ticket.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        a1StartScreenWithClip,
        a1StartScreen,
        avatar1,
        avatar2,
        avatar3,
        avatar4,
        avatar5,
        avatar6,
        avatar7,
        avatar8,
        buttonNext,
        cart,
        coin,
        formBg,
        hair,
        loginDone,
        logo,
        morpheus,
        passwordBg,
        rug,
        support,
        ticket
      ];
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/password.svg
  String get password => 'assets/svg/password.svg';

  /// List of all assets
  List<String> get values => [password];
}

class Assets {
  const Assets._();

  static const $AssetsImageGen image = $AssetsImageGen();
  static const $AssetsSvgGen svg = $AssetsSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
