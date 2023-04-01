function received_packet() {
buffer = argument0;
msgid = buffer_read(buffer,buffer_u8);


switch(msgid)
{
	case network.enemy_draw_map_change:
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_name = buffer_read(buffer,buffer_string);
		var aggro_target = buffer_read(buffer,buffer_string);
		var e_hpc = buffer_read(buffer,buffer_u16);
		
		if enemy_name == "enm_slime_green" {
			target = instance_create_depth(_x, _y, _y, enm_slime_green);
			target.hpm = e_hpc;
		}
			
		target.hpc = e_hpc;
		target.aggro_target = aggro_target;
		
		
		break;
	case network.enemy_spawn:
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_name = buffer_read(buffer,buffer_string);
		var e_hpc = buffer_read(buffer,buffer_u16);
		
		if enemy_name == "enm_slime_green"
			target = instance_create_depth(_x, _y, _y, enm_slime_green);
			
		target.hpc = e_hpc;
		target.hpm = e_hpc;
		
		break;
	case network.player_teleport:
		var target_location = buffer_read(buffer,buffer_string);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var _username = buffer_read(buffer,buffer_string);
		
		//if target_location == "rm_field01" {
		//	room_goto(rm_field01);
		//}
		//if target_location == "rm_client" {
		//	room_goto(rm_client);
		//}
		
		instance_destroy(obj_player);
		
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.player_remake);
		buffer_write(con_client.client_buffer,buffer_string,"null");
		buffer_write(con_client.client_buffer,buffer_string,target_location);
		buffer_write(con_client.client_buffer,buffer_u16,_x);
		buffer_write(con_client.client_buffer,buffer_u16,_y);
		buffer_write(con_client.client_buffer,buffer_string,_username);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

		
		break;
		
	case network.enemy_movement:
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var e_direction = buffer_read(buffer,buffer_u8);
		var enemy_name = buffer_read(buffer,buffer_string);
		var aggro_target = buffer_read(buffer,buffer_string);
		
		if enemy_name == "enm_slime_green"
			target = instance_position(_x, _y, enm_slime_green);
		
		
		target_ready = instance_position(_x, _y, ready_move);
		if instance_exists(target_ready) {
			with target_ready {
				instance_destroy();	
			}
		}
				
		
		if instance_exists(target) {
			
			target.aggro_target = aggro_target;
			target.aggro_timer = 3;
			if e_direction == 1
				target.y -= 64;
			
			if e_direction == 3
				target.y += 64;
			
			if e_direction == 2
				target.x += 64;
			
			if e_direction == 4
				target.x -= 64;
			
			target.alarm[1] = room_speed;
		}
			
		
		
	
		break;
	case network.enemy_take_damage:
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_HP = buffer_read(buffer,buffer_u16);
		var mons_id = buffer_read(buffer,buffer_string);
		
			
		target = -1;
		if mons_id == "enm_slime_green" {
			target = instance_position(_x, _y, enm_slime_green);
		}
		
		
		if instance_exists(target)
			target.hpc = enemy_HP;
		
		break;
	case network.enemy_die:
		var death_x = buffer_read(buffer,buffer_u16);
		var death_y = buffer_read(buffer,buffer_u16);
		var death_id = buffer_read(buffer,buffer_string);
		
		target = -1;
		#region list of ids
		if death_id == "enm_slime_green"
			target = enm_slime_green;
		#endregion
		
		instance_destroy(instance_position(death_x, death_y, target));
		
		break;
	
	case network.add_to_console:
		var _string = buffer_read(buffer,buffer_string);
		add_to_console(_string);
		
		break;
		
	case network.make_character:
		_username = buffer_read(buffer,buffer_string);
		global.username = _username;
		room_goto(rm_customize);
		
		break;
		
		
	case network.second_update:
		if instance_exists(con_gui) {
			con_gui.class = buffer_read(buffer,buffer_string);
			con_gui.level = buffer_read(buffer,buffer_u8);
			con_gui.hp_c = buffer_read(buffer,buffer_u16);
			con_gui.hp_m = buffer_read(buffer,buffer_u16);
			con_gui.exp_c = buffer_read(buffer,buffer_u16);
			con_gui.exp_m = buffer_read(buffer,buffer_u16);
			con_gui.vit = buffer_read(buffer,buffer_u8);
			con_gui.endu = buffer_read(buffer,buffer_u8);
			con_gui.str = buffer_read(buffer,buffer_u8);
			con_gui.int = buffer_read(buffer,buffer_u8);
			con_gui.dex = buffer_read(buffer,buffer_u8);
			con_gui.agi = buffer_read(buffer,buffer_u8);
		}
		break;
	
	case network.second_update_other:
		if room != rm_file_select {
			var _sock = buffer_read(buffer,buffer_u8);
			var _hpc = buffer_read(buffer,buffer_u16);
			var _hpm = buffer_read(buffer,buffer_u16);
			
			var _player = ds_map_find_value(socket_to_instanceid,_sock);
			
			
			if instance_exists(_player) {
				_player.hp_c = _hpc;
				_player.hp_m = _hpm;
			}
				
		}
		
		
		break;
		
	case network.turn:
		if room != rm_file_select {
			var _sock = buffer_read(buffer,buffer_u8);
			var _direction = buffer_read(buffer,buffer_u8);
		
			var _player = ds_map_find_value(socket_to_instanceid,_sock);
			if instance_exists(_player) {
				if _direction == 1 {
					_player.move_direction = 1
				}
		
				if _direction == 2 {
					_player.move_direction = 2
				}
		
				if _direction == 3 {
					_player.move_direction = 3
				}
		
				if _direction == 4 {
					_player.move_direction = 4
				}
			}
		}
		break;
		
	case network.player_new:
		
		con_login.success = 1;
		
		break;
	case network.player_new_fail:
		con_login.input_username = "";
		con_login.input_password = "";
		con_login.fail = 2;
		keyboard_string = "";
		
		break;
	case network.player_login_fail:
		con_login.input_username = "";
		con_login.input_password = "";
		con_login.fail = 1;
		keyboard_string = "";
		
		
		break;
		
	//case network.player_establish:
	//	var _socket = buffer_read(buffer,buffer_u8);
	//	global.mysocket = _socket;
		
	//	buffer_seek(client_buffer,buffer_seek_start,0);
	//	buffer_write(client_buffer,buffer_u8,network.player_establish);
	//	buffer_write(client_buffer,buffer_string,global.username);
	//	network_send_packet(client,client_buffer,buffer_tell(client_buffer));

		
	//	break;
		
		
	case network.player_connect:
		if room != rm_mainmenu {
			var _socket = buffer_read(buffer,buffer_u8);
			var _x = buffer_read(buffer,buffer_u16);
			var _y = buffer_read(buffer,buffer_u16);
			var _gender = buffer_read(buffer,buffer_u8);
			var _customize = buffer_read(buffer,buffer_u8);
			var _username = buffer_read(buffer,buffer_string);
			var room_name = buffer_read(buffer,buffer_string);
			
			var _player = instance_create_depth(_x,_y,_y,obj_player);
			_player.socket = _socket;
			_player.username = _username;
			_player.gender = _gender;
			global.username = _username;
		
			if _gender == 1
				_player.sprite_id = spr_wanderer_male;
			else
				_player.sprite_id = spr_wanderer_female;
			
			obj_player.sprite_x = obj_player.x;
			obj_player.sprite_y = obj_player.y;
			
			camera_apply(view_camera[0]);
		

		
			ds_map_clear(socket_to_instanceid);
			ds_map_add(socket_to_instanceid,_socket,_player);
		
			if room_name == "rm_client"
				room_goto(rm_client);
			if room_name == "rm_field01"
				room_goto(rm_field01);
		
		
		}
		break;
	
	case network.player_joined:
		var _socket = buffer_read(buffer,buffer_u8);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var _gender = buffer_read(buffer,buffer_u8);
		var _username = buffer_read(buffer,buffer_string);
		
		
//		if ds_map_exists(socket_to_instanceid,_socket) == false {
		var _slave = instance_create_depth(_x,_y,_y,obj_slave);
		_slave.socket = _socket;
		_slave.username = _username;
		_slave.gender = _gender;
		if _gender == 1
			_slave.sprite_id = spr_wanderer_male;
		else
			_slave.sprite_id = spr_wanderer_female;
		ds_map_add(socket_to_instanceid,_socket,_slave);
//		}
		break;
		
	case network.player_disconnect:
		var _socket = buffer_read(buffer,buffer_u8);
			
		if is_undefined(_socket) == false {
			var _player = ds_map_find_value(socket_to_instanceid,_socket);
			if instance_exists(_player) {
				if is_undefined(_player) == false {
					with(_player)
					{
						instance_destroy();
					}
					ds_map_delete(socket_to_instanceid,_socket);
				}
			}
		}
		break;
		
	case network.move: 
		if room != rm_file_select {
			var _sock = buffer_read(buffer,buffer_u8);
			var move_x = buffer_read(buffer,buffer_u16);
			var move_y = buffer_read(buffer,buffer_u16);
			
			_player = ds_map_find_value(socket_to_instanceid,_sock);
			
			if instance_exists(_player)  {
				_player.x = move_x;
				_player.y = move_y;
			}
		}
		break;
		
	case network.chat:
		if room != rm_file_select {
			var _chat = buffer_read(buffer,buffer_string);
			var _color = buffer_read(buffer,buffer_u8);
			var _listing = "";
		
			// Message formatting for line efficiency
			if string_length(_chat) < 33 {
				ds_list_insert(global.chat,0,_chat);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			}
		
		
			if string_length(_chat) >= 33 and string_length(_chat) < 65{
				_listing = string_copy(_chat,1,32);
				ds_list_insert(global.chat,0,_listing);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			
				_listing = string_copy(_chat,33,32);
				ds_list_insert(global.chat,0,_listing);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			}
		
			if string_length(_chat) >= 65 {
				_listing = string_copy(_chat,1,32);
				ds_list_insert(global.chat,0,_listing);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			
				_listing = string_copy(_chat,33,32);
				ds_list_insert(global.chat,0,_listing);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			
				_listing = string_copy(_chat,65,32);
				ds_list_insert(global.chat,0,_listing);
			
				if _color = 1 //player color
					ds_list_insert(global.chat_color,0,c_white);
				if _color = 2 //server color
					ds_list_insert(global.chat_color,0,c_red);
			}
		}
		
		break;
}
}