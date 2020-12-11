precision mediump float;
varying vec3 vnormal;
uniform float t;
uniform vec2 resolution;

bool aboveSin(vec4 coord) {
    if (coord.y > (sin(t + coord.x*0.1)+1.0)*resolution.x*0.5) return true;
    return false;
}

void main () {
    vec4 color = vec4(abs(vnormal) * (sin(t)+1.0), 1.0);
    if (aboveSin(gl_FragCoord)) {
        color = vec4(0.0);
    }
    // gl_FragColor = vec4(abs(vnormal), 1.0);
    gl_FragColor = color;
}