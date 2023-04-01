alarm[1] = room_speed;

if aggro_timer > 0 {
	aggro_timer = aggro_timer - 1;
}
	
if aggro_timer == 0 {
	aggro_target = "";
	aggro_timer = 3;
}
