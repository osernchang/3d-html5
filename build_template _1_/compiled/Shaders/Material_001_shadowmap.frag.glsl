#version 450
in vec2 texCoord;
uniform sampler2D ImageTexture;
void main() {
	vec4 ImageTexture_texread_store = texture(ImageTexture, texCoord.xy);
	vec3 n;
	float dotNV;
	float opacity;
	float ImageTexture_Alpha_res = ImageTexture_texread_store.a;
	opacity = ImageTexture_Alpha_res - 0.0002;
	if (opacity < 0.10000000149011612) discard;
}
