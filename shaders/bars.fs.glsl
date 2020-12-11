precision mediump float;
uniform float t;
uniform vec2 resolution;
uniform sampler2D texture;

bool bars(vec4 coord) {
    return (mod(coord.y + t*100.0, 10.0) < 5.0);
}

void main () {
    vec2 st = vec2(gl_FragCoord.x/resolution.x, gl_FragCoord.y/resolution.y);
    vec4 bar = bars(gl_FragCoord) ? vec4(vec3(0.9), 1.0) : vec4(1.0);

    gl_FragColor = texture2D(texture, st) * bar;
    // gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}