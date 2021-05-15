shader_type canvas_item;

uniform bool outline_enabled;
uniform bool blink;
uniform vec4 outline_color: hint_color;

void fragment()
{
	vec4 sprite_color = texture(TEXTURE, UV);
	if (outline_enabled)
	{
		float size = 1.0 * TEXTURE_PIXEL_SIZE.x;
	
		float alpha = -4.0 * sprite_color.a;
		alpha += texture(TEXTURE, UV + vec2(size, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(-size, 0.0)).a;
		alpha += texture(TEXTURE, UV + vec2(0.0, size)).a;
		alpha += texture(TEXTURE, UV + vec2(0.0, -size)).a;
		
		vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
		COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
	}
	else
	{
		COLOR = sprite_color;
	}
		
	if (blink) 
	{
		vec4 color = texture(TEXTURE, UV);
		COLOR = vec4(color.r + .5, color.g + .5, color.b + .5, color.a)
	}
}