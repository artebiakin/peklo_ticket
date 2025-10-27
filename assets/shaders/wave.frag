#version 460 core
precision highp float;

/*
  BLOOD FILL MASK — bottom → top
  Output: vec4(1,1,1, alpha)  (use with BlendMode.dstIn)
*/

// uniforms (match these indices from Dart)
layout(location = 0) uniform vec2  uSize;     // px
layout(location = 1) uniform float uT;        // 0..1 route progress
layout(location = 2) uniform float uTime;     // seconds
layout(location = 3) uniform float uFeather;  // px softness (e.g. 6–10)
layout(location = 4) uniform float uDripAmp;  // 0..1 drip intensity (e.g. 0.8)
layout(location = 5) uniform float uBlobAmp;  // 0..1 blobby edge (e.g. 0.6)

// output
layout(location = 0) out vec4 fragColor;

// ——— noise helpers ———
float hash(vec2 p){
  p = fract(p*vec2(123.34, 345.45));
  p += dot(p, p+34.345);
  return fract(p.x*p.y);
}
float noise(vec2 p){
  vec2 i = floor(p), f = fract(p);
  float a = hash(i);
  float b = hash(i+vec2(1,0));
  float c = hash(i+vec2(0,1));
  float d = hash(i+vec2(1,1));
  vec2 u = f*f*(3.0 - 2.0*f);
  return mix(mix(a,b,u.x), mix(c,d,u.x), u.y);
}
float fbm(vec2 p){
  float v=0.0, a=0.5;
  for(int i=0;i<5;i++){ v += a*noise(p); p*=2.0; a*=0.5; }
  return v;
}

// Signed distance to a viscous “blood” surface rising bottom→top
// Positive below the surface (visible), negative above (hidden).
float bloodSurfaceSD(vec2 p, float t, float time){
  float w = uSize.x, h = uSize.y;

  // base height: rise from bottom to top with a slow-in, fast-out curve
  float base = h * smoothstep(0.0, 1.0, pow(t, 0.82));

  // blobby, siney edge that depends on x and time
  float x = p.x / w;
  float wobble =
      (sin((x*8.0 + time*1.2)) * 10.0 +
       sin((x*17.0 - time*0.8)) * 6.0) * uBlobAmp;

  // larger-scale organic undulation
  float und = (fbm(vec2(x*2.0, time*0.4)) - 0.5) * 40.0 * uBlobAmp;

  // hanging drips that stretch downward and sway
  float dripGrid = floor(x*10.0);
  float dripSeed = hash(vec2(dripGrid, 7.0));
  float dripPhase = time*1.3 + dripSeed*6.28;
  float dripLen = mix(18.0, 70.0, dripSeed) * uDripAmp;
  float sway = sin(dripPhase + x*30.0) * mix(2.0, 6.0, dripSeed);
  float drip = -max(0.0, dripLen * (0.8 + 0.2*sin(dripPhase))) +
               sway;

  // a few extra small drips between main ones
  float drip2Seed = hash(vec2(dripGrid+0.5, 13.0));
  float drip2 = -max(0.0, mix(6.0, 24.0, drip2Seed) * uDripAmp * 0.7);

  float surfaceY = base + wobble + und;
  // “attach” drips below the surface at their grid columns
  float isCol = step(0.96, noise(vec2(dripGrid*0.37, 0.0))); // randomly enable columns
  surfaceY += isCol * max(drip, drip2);

  // signed distance: positive below (visible), negative above
  return (p.y - surfaceY);
}

void main(){
  vec2 p = gl_FragCoord.xy;

  float t = clamp(uT, 0.0, 1.0);
  float sd = bloodSurfaceSD(p, t, uTime);

  // Convert signed distance to alpha; below surface = 1
  float alpha = smoothstep(0.0, uFeather, sd);

  // tiny foam/bubble near the surface
  float edge = 1.0 - clamp(sd / (uFeather + 1.0), 0.0, 1.0);
  float micro = noise(p*vec2(1.2, 1.4) + uTime*8.0);
  alpha = clamp(alpha + edge * smoothstep(0.75, 1.0, micro) * 0.15, 0.0, 1.0);

  fragColor = vec4(1.0, 1.0, 1.0, alpha);
}