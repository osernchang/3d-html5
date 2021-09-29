#version 450
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec2 texCoord;
in vec3 wnormal;
out vec4 fragColor[2];
uniform sampler2D ImageTexture_001;
void main() {
vec3 n = normalize(wnormal);
	vec4 ImageTexture_001_texread_store = texture(ImageTexture_001, texCoord.xy);
	ImageTexture_001_texread_store.rgb = pow(ImageTexture_001_texread_store.rgb, vec3(2.2));
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	float emission;
	const float MixShader_fac = 0.0;
	const float MixShader_fac_inv = 1.0 - MixShader_fac;
	vec3 ImageTexture_001_Color_res = ImageTexture_001_texread_store.rgb;
	basecol = (ImageTexture_001_Color_res * MixShader_fac_inv + vec3(0.8) * MixShader_fac);
	roughness = (0.06818181276321411 * MixShader_fac_inv + 0.0 * MixShader_fac);
	metallic = (0.0 * MixShader_fac_inv + 0.0 * MixShader_fac);
	occlusion = (1.0 * MixShader_fac_inv + 1.0 * MixShader_fac);
	specular = (0.8999999761581421 * MixShader_fac_inv + 1.0 * MixShader_fac);
	emission = (0.0 * MixShader_fac_inv + 0.0 * MixShader_fac);
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	uint matid = 0;
	if (emission > 0) { basecol *= emission; matid = 1; }
	fragColor[0] = vec4(n.xy, roughness, packFloatInt16(metallic, matid));
	fragColor[1] = vec4(basecol, packFloat2(occlusion, specular));
}
