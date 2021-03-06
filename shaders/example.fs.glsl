precision mediump float;
uniform sampler2D texture;
uniform vec2 mouse;
uniform float t;
varying vec2 uv;
void main () {
    float dist = length(gl_FragCoord.xy - mouse);
    vec4 temp = vec4(
        0.80 * texture2D(
            texture,
            uv + cos(t) * vec2(0.5 - uv.y, uv.x - 0.5) - sin(2.0 * t) * (uv - 0.5)
        ).rgb,
        1
    ) +
      exp(-0.01 * dist) * vec4(
        1.0 + cos(2.0),
        1.0 + sin(2.0 * t + 4.0),
        1.0 + cos(2.0 * t + 1.0),
        1.0
    );

    if (gl_FragCoord.x < mouse.x && gl_FragCoord.y > mouse.y) {
        gl_FragColor = temp * vec4(0.7, 0.6, 0.6, 1);
    } else if (gl_FragCoord.x > mouse.x && gl_FragCoord.y < mouse.y) {
        gl_FragColor = temp * vec4(0.6, 0.6, 0.7, 1);
    } else {
        gl_FragColor = temp;
    }
}