shader_type canvas_item;

void fragment() {
	COLOR.rgb = texture(TEXTURE, UV).rgb;
	COLOR.a = 0.0;
}
