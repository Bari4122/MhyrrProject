if attack == 0 {

	attack = 1;	
	ds_list_insert(global.console, 0, "You swing your fist!")
	
	if move_direction == 1 {
		var target_x = x;	
		var target_y = y - 64;	
	}
	
	
	if move_direction == 2 {
		var target_x = x + 64;	
		var target_y = y;	
	}
	
	if move_direction == 3 {
		var target_x = x;	
		var target_y = y + 64;	
	}
	
	if move_direction == 4 {
		var target_x = x - 64;	
		var target_y = y;	
	}
	target = 0;
	found = 0;
	enemy_name = "null";
	
	target = instance_place(target_x, target_y, enm_slime_green);
	if target > 0 {
		found = 1;
		enemy_name = "enm_slime_green";
		target_health = target.hpc;
	}
	
	
	if found > 0 {	
		
	
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.player_attack);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,enemy_name);
		buffer_write(con_client.client_buffer,buffer_u16,target_health);
		buffer_write(con_client.client_buffer,buffer_u16,target_x);
		buffer_write(con_client.client_buffer,buffer_u16,target_y);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,global.username);
		buffer_write(con_client.client_buffer,buffer_string,target.aggro_target);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

	}
	
}