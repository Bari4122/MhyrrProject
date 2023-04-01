alarm[1] = room_speed / 12;

if move_direction == 3 {
	if sprite_frame > 3
		sprite_frame = 0
}
	
if move_direction == 2 {
	if sprite_frame > 7 or sprite_frame < 4
		sprite_frame = 4
}
	
if move_direction == 1 {
	if sprite_frame > 11 or sprite_frame < 8
		sprite_frame = 8
}
	
if move_direction == 4 {
	if sprite_frame > 15 or sprite_frame < 12
		sprite_frame = 12
	}

if sprite_x != x or sprite_y != y {
	var reset = 0;
	
	
	if move_direction == 3 {
		if sprite_frame == 3 {
			sprite_frame = 0
			reset = 1;
		}
	}
	
	if move_direction == 2 {
		if sprite_frame == 7 {
			sprite_frame = 4
			reset = 1;
		}
	}
	
	if move_direction == 1 {
		if sprite_frame == 11 {
			sprite_frame = 8
			reset = 1;
		}
	}
	
	if move_direction == 4 {
		if sprite_frame == 15 {
			sprite_frame = 12
			reset = 1;
		}
	}
	
	if reset == 0
		sprite_frame += 1
	
}
else {
	if move_direction == 1
		sprite_frame = 9
	if move_direction == 2
		sprite_frame = 5
	if move_direction == 3
		sprite_frame = 1
	if move_direction == 4
		sprite_frame = 13
}
