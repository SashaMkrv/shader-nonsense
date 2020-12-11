precision mediump float;
uniform vec2 resolution;
uniform sampler2D texture;

float floatToBase(float x, float base) {
    return floor(x * base)/base;
}

vec3 flattenColor(sampler2D texture, vec2 st, float base) {
    return vec3(
        floatToBase(texture2D(texture, st).rgb.x, base),
        floatToBase(texture2D(texture, st).rgb.y, base),
        floatToBase(texture2D(texture, st).rgb.z, base)
    );
}

void main () {
    vec2 st = vec2(gl_FragCoord.x/resolution.x, gl_FragCoord.y/resolution.y);

    gl_FragColor = vec4(flattenColor(texture, st, 4.0), 1.0);
    // gl_FragColor = vec4(1.0);
}