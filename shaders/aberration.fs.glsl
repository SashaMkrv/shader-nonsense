precision mediump float;
uniform float t;
uniform vec2 resolution;
uniform sampler2D texture;

bool bars(vec4 coord) {
    return (mod(coord.y + t*100.0, 10.0) < 5.0);
}

vec3 aberrateColor(sampler2D texture, vec2 st, float error) {
    return vec3(
        texture2D(texture, st - vec2(error)).rgb.x,
        texture2D(texture, st + vec2(error)).rgb.y,
        texture2D(texture, st - vec2(0.0, error)).rgb.z
    );
}

void main () {
    vec2 st = vec2(gl_FragCoord.x/resolution.x, gl_FragCoord.y/resolution.y);
    vec4 bar = bars(gl_FragCoord) ? vec4(vec3(0.9), 1.0) : vec4(1.0);

    gl_FragColor = vec4(aberrateColor(texture, st, 0.01), 1.0) * bar;
    // gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
}