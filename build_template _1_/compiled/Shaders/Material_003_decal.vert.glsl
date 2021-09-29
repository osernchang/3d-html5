#version 450
in vec3 pos;
in vec2 tex;
out vec4 wvpposition;
out vec3 wnormal;
uniform mat4 WVP;
uniform mat3 N;
void main() {
	wnormal = N * vec3(0.0, 0.0, 1.0);
	wvpposition = WVP * vec4(pos.xyz, 1.0);
	gl_Position = wvpposition;
}
