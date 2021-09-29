#version 450
#include "compiled.inc"
#include "std/gbuffer.glsl"
in vec4 wvpposition;
in vec3 wnormal;
out vec4 fragColor[2];
uniform sampler2D gbufferD;
uniform mat4 invVP;
uniform mat4 invW;
uniform sampler2D ImageTexture;
void main() {
    vec3 n = normalize(wnormal);
    vec2 screenPosition = wvpposition.xy / wvpposition.w;
    vec2 depthCoord = screenPosition * 0.5 + 0.5;
#ifdef HLSL
    depthCoord.y = 1.0 - depthCoord.y;
#endif
    float depth = texture(gbufferD, depthCoord).r * 2.0 - 1.0;
    vec3 wpos = getPos2(invVP, depth, depthCoord);
    vec4 mpos = invW * vec4(wpos, 1.0);
    if (abs(mpos.x) > 1.0) discard;
    if (abs(mpos.y) > 1.0) discard;
    if (abs(mpos.z) > 1.0) discard;
    vec2 texCoord = mpos.xy * 0.5 + 0.5;
	vec4 ImageTexture_texread_store = texture(ImageTexture, texCoord.xy);
	ImageTexture_texread_store.rgb = pow(ImageTexture_texread_store.rgb, vec3(2.2));
	vec3 basecol;
	float roughness;
	float metallic;
	float occlusion;
	float specular;
	float opacity;
	float emission;
	vec3 ImageTexture_Color_res = ImageTexture_texread_store.rgb;
	float ImageTexture_Alpha_res = ImageTexture_texread_store.a;
	basecol = ImageTexture_Color_res;
	roughness = 0.5;
	metallic = 0.0;
	occlusion = 1.0;
	specular = 0.5;
	emission = 0.0;
	opacity = ImageTexture_Alpha_res - 0.0002;
	n /= (abs(n.x) + abs(n.y) + abs(n.z));
	n.xy = n.z >= 0.0 ? n.xy : octahedronWrap(n.xy);
	fragColor[0] = vec4(n.xy, roughness, opacity);
	fragColor[1] = vec4(basecol.rgb, opacity);
}
