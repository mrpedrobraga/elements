shader_type spatial;
render_mode unshaded, cull_front;

varying vec3 world_camera;
varying vec3 world_position;

const int MAX_STEPS = 500;
const float MAX_DIST = 100.0;
const float SURF_DIST = 1e-3;

uniform sampler2D model : hint_albedo;
uniform vec3 model_size;

vec3 nsqr (vec3 v) {
	if (v.x > v.y && v.x > v.z) return vec3(1, v.y/v.x, v.z/v.x);
	if (v.y > v.x && v.y > v.z) return vec3(v.x/v.y, 1, v.z/v.y);
	return vec3(v.x/v.z, v.y/v.z, 1);
}

float snap(float v, float g) {
	return floor (v / g) * g;
}

vec2 snap2(vec2 v, vec2 g) {
	return floor (v / g) * g;
}

vec3 snap3(vec3 v, vec3 g) {
	return floor (v / g) * g;
}

vec4 texture3D ( sampler2D sampler, vec3 size, vec3 point ) {
	point = point + 0.5;
	vec3 s = 1./size;
	point = snap3(point + 0.5 * s, s) - 0.5 * s;
	
	vec4 r = texture(sampler, vec2(
		(point.x),
		(point.z)/size.y + snap(point.y, 1./size.y)
	));
	
	//r.rgb *= sin(point.z*20.0) * 0.3 + 0.7;
	
	return r;
}


// Box - unsigned - exact
/// <param name="p">Position.</param>
/// <param name="b">Bound(Scale).</param> 
float udBox( vec3 p, vec3 b )
{
  return length(max(abs(p)-b,0.0));
}

float GetDist(vec3 p){
	float d = length(p) - .5; //Sphere
	
	d = udBox(p, vec3(0.5, 0.5, 0.5));
	//d = length(vec2(length(p.xz) - .5, p.y)) - .1; //torus
	
	return d;
}

vec4 RayMarch(vec3 ro, vec3 rd) {
	float dO = 0.0;
	float dS = 1.0;
	float stepl = 0.005;
	vec3 p;
	bool hit = false;
	vec4 col = vec4(1.0, 1.0, 1.0, 1.0);
	
	for (int i = 0; i < MAX_STEPS; i++)
	{
		p = ro + dO * rd;
		col = texture3D(model, model_size, p);
		dS = GetDist(p);
		dO += dS > SURF_DIST? dS: stepl;
		
		if (dS < SURF_DIST && col.a > 0.5)
			{hit = true; break;}
		if (dO > MAX_DIST)
			break;
	}
	if (hit) return vec4(col.rgb, length(p - ro));
	return vec4(0.0, 0.0, 0.0, MAX_DIST);
}

vec3 GetNormal(vec3 p) {
	vec2 e = vec2(1e-2, 0);
	
	vec3 n = GetDist(p) - vec3(
		GetDist(p - e.xyy),
		GetDist(p - e.yxy),
		GetDist(p - e.yyx)
	);
	
	return normalize(n);
}

void vertex() {
	world_position = VERTEX;
	world_camera = (inverse(MODELVIEW_MATRIX) * vec4(0, 0, 0, 1)).xyz; //object space
	//world_camera = ( CAMERA_MATRIX  * vec4(0, 0, 0, 1)).xyz; //uncomment this to raymarch in world space
}

void fragment() {
	
	vec3 ro = world_camera;
	vec3 rd =  normalize(world_position - ro);
	
	vec3 col;
	
	vec4 p = RayMarch(ro, rd);

	if (p.w >= MAX_DIST) {
		discard;
	}
	else
	{
		col = p.rgb;
	}
	
	ALBEDO = clamp(col, vec3(0.0), vec3(1.0));
}