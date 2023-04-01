image_alpha = 1;
var collide = collision_rectangle(x, y, x + sprite_width - 1, y + sprite_height - 1, all, true, true);
if collide != noone 
	image_alpha = 0.5;