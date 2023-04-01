camera_x = sprite_x - 480;
camera_y = sprite_y - 512;
if camera_x < 0
	camera_x = 0
if camera_y < 0
	camera_y = 0
if camera_x + 1024 > room_width {
	camera_x = room_width - 1024
}
if camera_y + 1024 > room_height {
	camera_y = room_height - 1024
}
camera_set_view_pos(view_camera[0], camera_x, camera_y)
//camera_set_view_pos(view_camera[0], 0, 0)

sprite_index = spr_empty
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if room != rm_file_select {
	//draw health bar
	hp_bar = con_gui.hp_m / 10;
	#region Setting the frame for the health bar
	if con_gui.hp_c == con_gui.hp_m
		health_bar = 0
	
	if con_gui.hp_c < con_gui.hp_m
		health_bar = 1
	
	if con_gui.hp_c <= hp_bar * 8
		health_bar = 2
	
	if con_gui.hp_c <= hp_bar * 7
		health_bar = 3
	
	if con_gui.hp_c <= hp_bar * 6
		health_bar = 4
	
	if con_gui.hp_c <= hp_bar * 5
		health_bar = 5
	
	if con_gui.hp_c <= hp_bar * 4
		health_bar = 6
	
	if con_gui.hp_c <= hp_bar * 3
		health_bar = 7
	
	if con_gui.hp_c <= hp_bar * 2
		health_bar = 8
	
	if con_gui.hp_c <= hp_bar * 1
		health_bar = 9
	
	if con_gui.hp_c < 1
		health_bar = 10
	#endregion
	draw_sprite(spr_small_health_bar, health_bar, sprite_x+4,sprite_y-4);
}


if room == rm_file_select or room == rm_customize {
	sprite_id = spr_empty;
}
else {
	if gender == 1 
		sprite_id = spr_wanderer_male
	else
		sprite_id = spr_wanderer_female
	draw_self();
	draw_set_color(c_white);
	draw_text(sprite_x+32,sprite_y-16,username);
}
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

//draw_set_alpha(0.5);

if instance_position(sprite_x, sprite_y, wall_water) {
//	draw_sprite(spr_water_step, water_index, sprite_x, sprite_y);
	draw_sprite(spr_water_splash, splash_index, sprite_x, sprite_y);
}

//draw_set_alpha(1);
