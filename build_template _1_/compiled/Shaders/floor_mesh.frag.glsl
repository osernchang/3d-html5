#version 450
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec2 texCoord;
in mat3 TBN;
out vec4 fragColor[2];
uniform sampler2D ImageTexture_001;
uniform sampler2D ImageTexture;
void main() {
	vec4 ImageTexture_001_texread_store = texture(ImageTexture_001, texCoord.xy);
	vec4 ImageTexture_texread_store = texture(ImageTexture, texCoord.xy);
	ImageTexture_texread_store.rgb = pow(ImageTexture_texread_store.rgb, vec3(2.2));
	vec3 ImageTexture_001_Color_res = ImageTexture_001_texread_store.rgb;
	vec3 n = (ImageTexture_001_Color_res) * 2.0 - 1.0;
	n.xy *= 10.0;
	n = normalize(TBN * n);
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	float emission;
	vec3 ImageTexture_Color_res = ImageTexture_texread_store.rgb;
	float SeparateRGB_B_res = ImageTexture_Color_res.b;
	basecol = (vec3(SeparateRGB_B_res) + ImageTexture_Color_res);
	roughness = (0.09999998658895493 * 0.5 + 0.0 * 0.5);
	metallic = (1.0 * 0.5 + 0.0 * 0.5);
	occlusion = (1.0 * 0.5 + 1.0 * 0.5);
	specular = (1.0 * 0.5 + 0.0 * 0.5);
	emission = (0.0 * 0.5 + 0.0 * 0.5);
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	uint matid = 0;
	if (emission > 0) { basecol *= emission; matid = 1; }
	fragColor[0] = vec4(n.xy, roughness, packFloatInt16(metallic, matid));
	fragColor[1] = vec4(basecol, packFloat2(occlusion, specular));
}
