#version 450
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec2 texCoord;
in vec3 wnormal;
out vec4 fragColor[2];
uniform sampler2D ImageTexture;
void main() {
vec3 n = normalize(wnormal);
	vec4 ImageTexture_texread_store = texture(ImageTexture, texCoord.xy);
	ImageTexture_texread_store.rgb = pow(ImageTexture_texread_store.rgb, vec3(2.2));
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	float emission;
	float opacity;
	vec3 ImageTexture_Color_res = ImageTexture_texread_store.rgb;
	float ImageTexture_Alpha_res = ImageTexture_texread_store.a;
	basecol = ImageTexture_Color_res;
	roughness = 1.0;
	metallic = 0.0;
	occlusion = 1.0;
	specular = 1.0;
	emission = 12.999999046325684;
	opacity = ImageTexture_Alpha_res - 0.0002;
	if (opacity < 0.20000000298023224) discard;
	if (!gl_FrontFacing) n *= -1;
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	uint matid = 0;
	if (emission > 0) { basecol *= emission; matid = 1; }
	fragColor[0] = vec4(n.xy, roughness, packFloatInt16(metallic, matid));
	fragColor[1] = vec4(basecol, packFloat2(occlusion, specular));
}
