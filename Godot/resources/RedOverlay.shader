shader_type canvas_item;

uniform bool enabled;

void fragment()
{
	if(enabled)
	{
		vec4 color = texture(TEXTURE, UV);
		COLOR = vec4(color.r + .5, color.g + .1, color.b + .1, color.a)
	}
	else
	{
		COLOR = texture(TEXTURE, UV)
	}
}