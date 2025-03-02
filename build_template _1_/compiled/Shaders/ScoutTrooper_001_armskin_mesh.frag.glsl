#version 450
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec2 texCoord;
in vec3 wnormal;
out vec4 fragColor[2];
uniform sampler2D ImageTexture;
uniform sampler2D ImageTexture_001;
void main() {
vec3 n = normalize(wnormal);
	vec4 ImageTexture_texread_store = texture(ImageTexture, texCoord.xy);
	ImageTexture_texread_store.rgb = pow(ImageTexture_texread_store.rgb, vec3(2.2));
	vec4 ImageTexture_001_texread_store = texture(ImageTexture_001, texCoord.xy);
	ImageTexture_001_texread_store.rgb = pow(ImageTexture_001_texread_store.rgb, vec3(2.2));
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	float emission;
	vec3 ImageTexture_Color_res = ImageTexture_texread_store.rgb;
	vec3 ImageTexture_001_Color_res = ImageTexture_001_texread_store.rgb;
	float SeparateRGB_G_res = ImageTexture_001_Color_res.g;
	float SeparateRGB_B_res = ImageTexture_001_Color_res.b;
	basecol = ImageTexture_Color_res;
	roughness = SeparateRGB_G_res;
	metallic = SeparateRGB_B_res;
	occlusion = 1.0;
	specular = 1.0;
	emission = 0.0;
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	uint matid = 0;
	if (emission > 0) { basecol *= emission; matid = 1; }
	fragColor[0] = vec4(n.xy, roughness, packFloatInt16(metallic, matid));
	fragColor[1] = vec4(basecol, packFloat2(occlusion, specular));
}
