shader_type canvas_item;

uniform bool show_uv;
uniform bool pixelate = true;
uniform sampler2D uv_map;

vec2 vgrid(vec2 v, vec2 grid) {
	return floor(v / grid) * grid;
}

void fragment() {
	vec4 col;
	vec2 uv = UV; vec2 ps = TEXTURE_PIXEL_SIZE * 2.0;
	
	vec2 uv_sampler = texture(TEXTURE, uv).xy;
	ivec2 uv_map_size = textureSize(uv_map, 0);
	
	ps = 1./vec2(uv_map_size);
	
	if ( pixelate ) {
		uv_sampler += 0.5 * ps;
		uv_sampler = vgrid(uv_sampler, ps);
		uv_sampler -= 0.5 * ps;
	}
	
	col = texture(uv_map, uv_sampler);
	
	if ( show_uv ) {
		col.rg = uv_sampler; col.b = 0.0;
	}
	
	COLOR = col;
}