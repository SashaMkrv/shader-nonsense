precision mediump float;
uniform mat4 projection, view;
uniform vec3 lightVector;
uniform vec3 eye;
attribute vec3 position, normal;
varying vec3 vnormal, light, cameraPosition;
varying vec3 toViewNormal;
void main () {
    vnormal = normal;
    light = normal * lightVector;
    mat4 view2 = projection * view;
    view2 = view;
    cameraPosition = vec3(view2[3][0], view2[3][1], view2[3][2]);
    vec3 cameraToPosition = eye - position;
    toViewNormal = normalize(cameraToPosition) * normal;
    gl_Position = projection * view * vec4(position, 1.0);
}