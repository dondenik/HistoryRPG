shader_type canvas_item;
uniform bool blue_colorise;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	if (COLOR.g >= 0.5 && blue_colorise == true) {
		COLOR.rg = vec2(0.1 * (10.0 * COLOR.g));
		COLOR.b = 0.1;
	}
}
