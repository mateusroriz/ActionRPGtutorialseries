shader_type canvas_item;

uniform bool active = false; //exporting the variable to use outside of here

void fragment(){
	vec4 previous_color = texture(TEXTURE, UV); // this saves the previous state of th esprite
	vec4 white_color = vec4(1.0,1.0,1.0,previous_color.a); //setting the sprite color as white but only on places there are not transparent
	vec4 new_color = previous_color;
	if(active == true){
		new_color = white_color;
	}
	COLOR = new_color; //this is the output
}