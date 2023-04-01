
alarm[0] = room_speed;
if place_meeting(x, y, ready_move) == false
	instance_create_layer(x, y, "Instances", ready_move);
