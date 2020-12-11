attribute vec2 position;
uniform float z;

void main() {
    gl_Position = vec4(position, z, 1.0);
}