shader_type canvas_item;

uniform vec4 shadow_color: hint_color;
uniform vec2 shadow_displacement;
uniform float alpha_limit: hint_range(0, 1.0) = 0.2;


void fragment()
{
	vec4 tex = texture(TEXTURE, UV);
	
	if (tex.a <= alpha_limit)
	{
		vec4 c = texture(TEXTURE, UV - shadow_displacement);
		COLOR.rgb = shadow_color.rgb;
		COLOR.a = mix(0.0, shadow_color.a, c.a);
	}
	else
	{
		COLOR = tex;
	}
}