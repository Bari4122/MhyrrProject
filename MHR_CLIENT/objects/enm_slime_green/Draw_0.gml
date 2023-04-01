
if sprite_x < x {
	sprite_x += 6
	if sprite_x > x
		sprite_x = x
}

if sprite_x > x {
	sprite_x -= 6
	if sprite_x < x
		sprite_x = x
}

if sprite_y < y {
	sprite_y += 6
	if sprite_y > y
		sprite_y = y
}

if sprite_y > y {
	sprite_y -= 6
	if sprite_y < y
		sprite_y = y
}

	
draw_sprite(sprite_id, sprite_frame, sprite_x, sprite_y);



//draw health bar
hp_bar = hpm / 10;
#region Setting the frame for the health bar
if hpc == hpm
	health_bar = 0
	
if hpc < hpm
	health_bar = 1
	
if hpc <= hp_bar * 8
	health_bar = 2
	
if hpc <= hp_bar * 7
	health_bar = 3
	
if hpc <= hp_bar * 6
	health_bar = 4
	
if hpc <= hp_bar * 5
	health_bar = 5
	
if hpc <= hp_bar * 4
	health_bar = 6
	
if hpc <= hp_bar * 3
	health_bar = 7
	
if hpc <= hp_bar * 2
	health_bar = 8
	
if hpc <= hp_bar * 1
	health_bar = 9
	
if hpc < 1
	health_bar = 10
#endregion
draw_sprite(spr_small_health_bar, health_bar, sprite_x+4,sprite_y-4);