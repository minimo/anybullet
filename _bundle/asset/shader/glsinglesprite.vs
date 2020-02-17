attribute vec2 position;
attribute vec2 uv;

uniform float instanceActive;
uniform vec3 instancePosition;
uniform vec2 instanceSize;
uniform float instanceAlphaEnabled;
uniform float instanceAlpha;
uniform float instanceBrightness;
uniform vec2 cameraMatrix0;
uniform vec2 cameraMatrix1;
uniform vec2 cameraMatrix2;
uniform vec2 screenSize;

varying float vBrightness;
varying float vAlphaEnabled;
varying float vAlpha;
varying vec2 vUv;

void main(void) {
  if (instanceActive == 0.0) {
    vAlphaEnabled = 0.0;
    vAlpha = 0.0;
    vBrightness = 0.0;
    vUv = uv;
    gl_Position = vec4(0.0);
  } else {
    vAlphaEnabled = instanceAlphaEnabled;
    vAlpha = instanceAlpha;
    vBrightness = instanceBrightness;
    vUv = uv;

    mat3 cameraMatrix = mat3(
      vec3(cameraMatrix0, 0.0),
      vec3(cameraMatrix1, 0.0),
      vec3(cameraMatrix2, 1.0)
    );

    mat3 m = mat3(
      1.0, 0.0, 0.0,
      0.0, 1.0, 0.0,
      instancePosition.xy, 1.0
    ) * mat3(
      instanceSize.x, 0.0, 0.0,
      0.0, instanceSize.y, 0.0,
      0.0, 0.0, 1.0
    );

    vec3 p = cameraMatrix * m * vec3(position, 1.0);
    vec3 p2 = (p + vec3(-screenSize.x * 0.5, -screenSize.y * 0.5, 0.0)) * vec3(1.0 / (screenSize.x * 0.5), -1.0 / (screenSize.y * 0.5), 0.0);
    p2.z = instancePosition.z * -0.001;
    gl_Position = vec4(p2, 1.0);
  }
}