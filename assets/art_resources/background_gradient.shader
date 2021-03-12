shader_type canvas_item;

uniform vec4 start_color: hint_color;
uniform vec4 end_color: hint_color;

void fragment()
{
	vec4 c = texture(TEXTURE, UV);
	COLOR.rgb = c.rgb * mix(end_color.rgb, start_color.rgb, UV.y);
	COLOR.a = c.a;
}