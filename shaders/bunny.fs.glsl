precision mediump float;
varying vec3 vnormal, light, toViewNormal;
uniform float t;
uniform vec2 resolution;
uniform sampler2D texture;
uniform bool round;

bool aboveSin(vec4 coord) {
    if (coord.y > (sin(t + coord.x*0.005)*0.25 + 0.6)*resolution.x*0.5 + 0.1) return true;
    return false;
}

bool bars(vec4 coord) {
    return (mod(coord.x + t*10.0, 60.0) < 25.0);
}

void main () {
    vec4 color = vec4(abs(vnormal * length(max(vec3(0.0), light))), 1.0);

    gl_FragColor = color;
    gl_FragColor = vec4(vec3(0.0), 1.0);

    if (length(toViewNormal) < 0.3) {
        gl_FragColor = vec4(1.0);
    }
}