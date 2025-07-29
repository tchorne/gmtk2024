shader_type canvas_item;
uniform float t;

float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(13.4331,72.15))) * 45458.912353);
}


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (random(round(UV*10.0)/10.0) < t){
		discard;
	}
	COLOR.rgb = vec3(1,0,0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
