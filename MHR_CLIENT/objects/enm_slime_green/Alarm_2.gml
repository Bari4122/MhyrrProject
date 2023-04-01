
alarm[2] = room_speed;

if attack_respawn == 2 {
	if place_meeting(x, y, ready_attack) == false
		instance_create_layer(x, y, "Instances", ready_attack);
}

if attack_respawn < 2 
	attack_respawn += 1;