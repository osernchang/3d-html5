#version 450
in vec4 pos;
in vec2 nor;
in vec2 tex;
in vec4 tang;
out vec2 texCoord;
out mat3 TBN;
uniform mat3 N;
uniform mat4 WVP;
uniform float texUnpack;
void main() {
vec4 spos = vec4(pos.xyz, 1.0);
texCoord = tex * texUnpack;
	vec3 wnormal = normalize(N * vec3(nor.xy, pos.w));
	gl_Position = WVP * spos;
	vec3 tangent = normalize(N * tang.xyz);
	vec3 bitangent = normalize(cross(wnormal, tangent));
	TBN = mat3(tangent, bitangent, wnormal);
}
