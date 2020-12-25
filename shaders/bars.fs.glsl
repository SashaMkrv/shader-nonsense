precision mediump float;
uniform float t;
uniform vec2 resolution;
uniform sampler2D texture;

bool bars(vec4 coord) {
    return (mod(coord.y + t*100.0, 10.0) < 5.0);
}

float ambiguousRound(float x, float base, float leeway) {
    return (
        floor(
            x * base + 1.0 + (1.0 - leeway)/(base + 1.0)
        ) - 1.0
    )/base;
}

float lowRoundFloat(float x, float base){
    return ambiguousRound(x, base, 0.0001);
}

float roundFloat(float x, float base) {
    return ambiguousRound(x, base, 0.0);
}

float thresholdFloat(float x, float base) {
    return lowRoundFloat(roundFloat(x, base + 1.0), base);
}

void main () {
    vec2 st = vec2(gl_FragCoord.x/resolution.x, gl_FragCoord.y/resolution.y);
    vec4 bar = bars(gl_FragCoord) ? vec4(vec3(0.9), 1.0) : vec4(1.0);

    vec4 color = texture2D(texture, st);
    float bits = 3.0;
    float stripeVal = 4.0;

    vec4 thresholdedColor = vec4(vec3(
        thresholdFloat(color.x, bits),
        thresholdFloat(color.y, bits),
        thresholdFloat(color.z, bits)
    ), 1.0);

    vec4 roundedColor = vec4(vec3(
        roundFloat(color.x, bits),
        roundFloat(color.y, bits),
        roundFloat(color.z, bits)
    ), 1.0);

    if (mod(gl_FragCoord.x, stripeVal) == mod(gl_FragCoord.y, stripeVal)) {
        color = thresholdedColor;
    } else {
        color = roundedColor;
    }

    // color = roundedColor;
    // color = thresholdedColor;

    gl_FragColor = color * bar;
    gl_FragColor = color; 
    // gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
}