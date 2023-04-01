if held_down > 0
held_down -= 1;

depth = -y;

if get_attacked == 0 {
	get_attacked = 1;
	target = -10;
	enemy_name = "null";
	
	target_ready = instance_nearest(x,y, ready_attack);
	
	
	if instance_exists(target_ready) {
		
	
	
		distance_x = abs(x - target.x);
		distance_y = abs(y - target.y);
	
		max_distance = (target.attack_range * 64) + 1;
		e_direction = 0;
	
		if distance_x < max_distance and distance_y < max_distance {
			attack_type = "basic";
			if position_meeting(target_ready.x, target_ready.y, enm_slime_green) {
				target = instance_place(target_ready.x, target_ready.y, enm_slime_green);
				enemy_name = "enm_slime_green";
				
			}
			
			if target != -10 {
				
				if target.aggro_target == global.username {
					
						buffer_seek(con_client.client_buffer,buffer_seek_start,0);
						buffer_write(con_client.client_buffer,buffer_u8,network.enemy_attack);
						buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
						buffer_write(con_client.client_buffer,buffer_u8,e_direction);
						buffer_write(con_client.client_buffer,buffer_u16,target.x);
						buffer_write(con_client.client_buffer,buffer_u16,target.y);
						buffer_write(con_client.client_buffer,buffer_string,enemy_name);
						buffer_write(con_client.client_buffer,buffer_string,global.username);
						buffer_write(con_client.client_buffer,buffer_string,attack_type);
						network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
					
					
				}
			}
		}
	}
}
		


if move_an_enemy == 0 {
	move_an_enemy = 1
	target = -10;
	enemy_name = "null";
	
	target_ready = instance_nearest(x, y, ready_move);
	
	if instance_exists(target_ready) {
		
		
		x_distance = abs(x - target_ready.x);
		y_distance = abs(y - target_ready.y);
	
		if x_distance < 384 and y_distance < 384 {
		
	
			if position_meeting(target_ready.x, target_ready.y, enm_slime_green) {
				target = instance_place(target_ready.x, target_ready.y, enm_slime_green);
				enemy_name = "enm_slime_green";
			}
		
			
		
			if target != -10 {
	
				if target.aggro_target == ""
					target.aggro_target = global.username;
	
				if target.aggro_target == global.username {
					look_to_x = x;
					e_direction = 0;
					e_movement = 0;
					if target.x > x {
						e_direction = 4	
						look_to_x = target.x - 64; 
					}
	
					if target.x < x {
						e_direction = 2	
						look_to_x = target.x + 64; 
					}
	
					if place_free(look_to_x, target.y) and e_direction > 0  and position_meeting(look_to_x, target.y, obj_player) == false and position_meeting(look_to_x, target.y, obj_slave) == false {
						e_movement = 1;
		
						buffer_seek(con_client.client_buffer,buffer_seek_start,0);
						buffer_write(con_client.client_buffer,buffer_u8,network.enemy_movement);
						buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
						buffer_write(con_client.client_buffer,buffer_u8,e_direction);
						buffer_write(con_client.client_buffer,buffer_u16,target.x);
						buffer_write(con_client.client_buffer,buffer_u16,target.y);
						buffer_write(con_client.client_buffer,buffer_string,enemy_name);
						buffer_write(con_client.client_buffer,buffer_u16,target.hpc);
						buffer_write(con_client.client_buffer,buffer_string,global.username);
						network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

		
					}
	
	
					if e_movement == 0 {
						
						look_to_y = y;
		
						if target.y > y {
							e_direction = 1	
							look_to_y = target.y - 64; 
						}
	
						if target.y < y {
							e_direction = 3
							look_to_y = target.y + 64; 
						}
		
						if place_free(target.x, look_to_y) and position_meeting(target.x, look_to_y, obj_player) == false and position_meeting(target.x, look_to_y, obj_slave) == false {
							e_movement = 1;
							buffer_seek(con_client.client_buffer,buffer_seek_start,0);
							buffer_write(con_client.client_buffer,buffer_u8,network.enemy_movement);
							buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
							buffer_write(con_client.client_buffer,buffer_u8,e_direction);
							buffer_write(con_client.client_buffer,buffer_u16,target.x);
							buffer_write(con_client.client_buffer,buffer_u16,target.y);
							buffer_write(con_client.client_buffer,buffer_string,enemy_name);
							buffer_write(con_client.client_buffer,buffer_u16,target.hpc);
							buffer_write(con_client.client_buffer,buffer_string,global.username);
							network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

		
					}
					}
					if e_movement == 0 {
						target.alarm[0] = room_speed;
					}
	
	
				}
			}
		}
	}
}