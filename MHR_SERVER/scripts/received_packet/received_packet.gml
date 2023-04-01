function received_packet() {


buffer = argument0;
socket = argument1;
msgid = buffer_read(buffer,buffer_u8);
room_name = buffer_read(buffer,buffer_string);
a_top_setlist();


switch(msgid)
{	
	case network.enemy_attack:
		var e_direction = buffer_read(buffer,buffer_u8);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_name = buffer_read(buffer,buffer_string);
		var _username = buffer_read(buffer,buffer_string);
		var attack_type = buffer_read(buffer,buffer_string);
		
		
		var i = 0;
			repeat(ds_list_size(socket_list))
			{
			
				var _sock = ds_list_find_value(socket_list,i)
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.enemy_attack)
				buffer_write(server_buffer,buffer_u16,_x)
				buffer_write(server_buffer,buffer_u16,_y)
				buffer_write(server_buffer,buffer_string,enemy_name)
				buffer_write(server_buffer,buffer_u16,e_hpc)
				network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
				i++
			}
		
		break;
	case network.enemy_spawn:
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_name = buffer_read(buffer,buffer_string);
		
		
		ini_open(global.directory + "\\monsters\\" + enemy_name + ".ini");
		e_lvl = ini_read_real("stats", "level", global.integer);
		e_vit = ini_read_real("stats", "vit", global.integer);
		ini_close();
		
		var e_hpc = 6 + (e_lvl * e_vit);
		
		var target = global.directory + "\\ini_saves\\" + room_name + ".ini"
		ini_open(target);
		section_name = string(_x) + "_" + string(_y);
		if ini_section_exists(section_name)
			ini_section_delete(section_name)
		ini_write_real(section_name, "x", _x)
		ini_write_real(section_name, "y", _y)
		ini_write_string(section_name, "type", enemy_name);
		ini_write_real(section_name, "hp", e_hpc);
		ini_close();
		
		var i = 0;
			repeat(ds_list_size(socket_list))
			{
			
				var _sock = ds_list_find_value(socket_list,i)
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.enemy_spawn)
				buffer_write(server_buffer,buffer_u16,_x)
				buffer_write(server_buffer,buffer_u16,_y)
				buffer_write(server_buffer,buffer_string,enemy_name)
				buffer_write(server_buffer,buffer_u16,e_hpc)
				network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
				i++
			}
		
		break;
	case network.player_remake:
		var target_location = buffer_read(buffer,buffer_string);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var _username = buffer_read(buffer,buffer_string);
	
		remove_from_list(socket);
		if target_location == "rm_client"
			ds_list_add(SL_rmclient,socket);
			
		if target_location == "rm_field01"
			ds_list_add(SL_rmfield01,socket);
		
		network_player_join(_username, _x, _y, target_location);
		
		
		break;
	case network.player_teleport:
		var _username = buffer_read(buffer,buffer_string);
		var target_location = buffer_read(buffer,buffer_string);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		
		buffer_seek(server_buffer,buffer_seek_start,0);
		buffer_write(server_buffer,buffer_u8,network.player_teleport);
		buffer_write(server_buffer,buffer_string,target_location);
		buffer_write(server_buffer,buffer_u16,_x)
		buffer_write(server_buffer,buffer_u16,_y)
		buffer_write(server_buffer,buffer_string,_username);
		network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		
		
		
		
		break;
	case network.enemy_movement:
		var e_direction = buffer_read(buffer,buffer_u8);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var enemy_name = buffer_read(buffer,buffer_string);
		var e_hpc = buffer_read(buffer,buffer_u16);
		var _username = buffer_read(buffer,buffer_string);
		
		new_x = _x;
		new_y = _y;
		
		if e_direction == 1
			new_y = _y - 64
			
		if e_direction == 2
			new_x = _x + 64
			
		if e_direction == 3
			new_y = _y + 64
				
		if e_direction == 4
			new_x = _x - 64
				
		old_section_name = string(_x) + "_" + string(_y);
		new_section_name = string(new_x) + "_" + string(new_y);
		var target = global.directory + "\\ini_saves\\" + room_name + ".ini"
		ini_open(target);
		if ini_section_exists(old_section_name)
			ini_section_delete(old_section_name)
		ini_write_real(new_section_name, "x", new_x)
		ini_write_real(new_section_name, "y", new_y)
		ini_write_string(new_section_name, "type", enemy_name)
		ini_write_string(new_section_name, "aggro", _username)
		ini_write_real(new_section_name, "hp", e_hpc);
		ini_close();
		
		var i = 0;
			repeat(ds_list_size(socket_list))
			{
			
				var _sock = ds_list_find_value(socket_list,i)
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.enemy_movement)
				buffer_write(server_buffer,buffer_u16,_x)
				buffer_write(server_buffer,buffer_u16,_y)
				buffer_write(server_buffer,buffer_u8,e_direction)
				buffer_write(server_buffer,buffer_string,enemy_name)
				buffer_write(server_buffer,buffer_string,_username)
				network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
				i++
			}
			
		break;
	case network.player_attack:
		var monster_id = buffer_read(buffer,buffer_string);
		var e_hpc = buffer_read(buffer,buffer_u16);
		var _x = buffer_read(buffer,buffer_u16);
		var _y = buffer_read(buffer,buffer_u16);
		var _room = buffer_read(buffer,buffer_string);
		var _username = buffer_read(buffer,buffer_string);
		var _aggro = buffer_read(buffer,buffer_string);
		
		
		console_response = "";
		
			
		//player stats
		ini_open(global.directory + "\\users\\" + _username + ".ini");
		p_vit = ini_read_real("stats", "vit", global.integer);
		p_end = ini_read_real("stats", "end", global.integer);
		p_str = ini_read_real("stats", "str", global.integer);
		p_int = ini_read_real("stats", "int", global.integer);
		p_dex = ini_read_real("stats", "dex", global.integer);
		p_agi = ini_read_real("stats", "agi", global.integer);
		ini_close();
			
		//enemy stats
		ini_open(global.directory + "\\monsters\\" + monster_id + ".ini");
		e_name = ini_read_string("monster", "name", global.string);
		e_vit = ini_read_real("stats", "vit", global.integer);
		e_end = ini_read_real("stats", "end", global.integer);
		e_str = ini_read_real("stats", "str", global.integer);
		e_int = ini_read_real("stats", "int", global.integer);
		e_dex = ini_read_real("stats", "dex", global.integer);
		e_agi = ini_read_real("stats", "agi", global.integer);
		ini_close();
			
		//hit check
		hit_chance = irandom(p_dex + 2);
		dodge_chance = irandom(e_agi + 2);
		if hit_chance >= dodge_chance { //if hit chance is greater than or equal to dodge chance, hit lands
			//damage roll
			damage = irandom(3)
			damage += p_str;
				
			//damage reduction
			//add damage reduction code based on e_end here
				
			//subtract damage from e_hpc
			e_hpc -= damage;
			console_response += "You dealt " + string(damage) + " damage to the " + string(e_name) + "!";
				
			//if the enemy is killed
			
			if e_hpc <= 0 {
				
				var target = global.directory + "\\ini_saves\\" + room_name + ".ini"
				ini_open(target);
				section_name = string(_x) + "_" + string(_y);
				if ini_section_exists(section_name)
					ini_section_delete(section_name)
				ini_close();
					
				console_response += " " + string(e_name) + " was killed!";
					
				var i = 0;
				repeat(ds_list_size(socket_list)) {
			
					var _sock = ds_list_find_value(socket_list,i);
			
						if ds_map_exists(socket_to_instanceid,_sock) {
							buffer_seek(server_buffer,buffer_seek_start,0);
							buffer_write(server_buffer,buffer_u8,network.enemy_die);
							buffer_write(server_buffer,buffer_u16,_x);
							buffer_write(server_buffer,buffer_u16,_y);
							buffer_write(server_buffer,buffer_string,monster_id);
							network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
			
					}
			
	
	
					
				i+=1;
				}
			}
					
				
		}	
		else
			console_response = "You missed!";
			
			
		buffer_seek(server_buffer,buffer_seek_start,0);
		buffer_write(server_buffer,buffer_u8,network.add_to_console);
		buffer_write(server_buffer,buffer_string,console_response);
		network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		
		
		if e_hpc > 0 {
			
			var target = global.directory + "\\ini_saves\\" + room_name + ".ini"
			ini_open(target);
			section_name = string(_x) + "_" + string(_y);
			if ini_section_exists(section_name) 
				ini_section_delete(section_name)
			ini_write_real(section_name, "x", _x)
			ini_write_real(section_name, "y", _y)
			ini_write_string(section_name, "type", monster_id)
			ini_write_string(new_section_name, "aggro", _aggro)
			ini_write_real(section_name, "hp", e_hpc);
			ini_close();
		
			var i = 0;
			repeat(ds_list_size(socket_list))
			{
			
				var _sock = ds_list_find_value(socket_list,i)
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.enemy_take_damage)
				buffer_write(server_buffer,buffer_u16,_x)
				buffer_write(server_buffer,buffer_u16,_y)
				buffer_write(server_buffer,buffer_u16,e_hpc)
				buffer_write(server_buffer,buffer_string,monster_id)
				network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
				i++
			}
		}
		break;
		
	case network.make_character:
		var _username = buffer_read(buffer,buffer_string);
		var gender_choice = buffer_read(buffer,buffer_u8);
		var personality_choice = buffer_read(buffer,buffer_u8);
		
		var target = global.directory + "\\users\\" + _username + ".ini"
		ini_open(target);
		if personality_choice == 1 {
			_vit = 2;
			_end = 1;
			_str = 3;
			_int = 1;
			_dex = 1;
			_agi = 1;
		}
		
		if personality_choice == 2 {
			_vit = 1;
			_end = 1;
			_str = 0;
			_int = 3;
			_dex = 3;
			_agi = 1;
		}
		
		if personality_choice == 3 {
			_vit = 3
			_end = 3;
			_str = 1;
			_int = 0;
			_dex = 1;
			_agi = 1;
		}
		
		if personality_choice == 4 {
			_vit = 1;
			_end = 0;
			_str = 1;
			_int = 5;
			_dex = 1;
			_agi = 1;
		}
		
		if personality_choice == 5 {
			_vit = 0;
			_end = 1;
			_str = 1;
			_int = 1;
			_dex = 2;
			_agi = 4;
		}
		
		if personality_choice == 6 {
			_vit = 1;
			_end = 0;
			_str = 1;
			_int = 1;
			_dex = 5;
			_agi = 1;
		}
		
		if personality_choice == 7 {
			_vit = 0;
			_end = 0;
			_str = 0;
			_int = 3;
			_dex = 3;
			_agi = 3;
		}
		
		_hpc = 10 + _vit;
		_hpm = 10 + _vit;
		
		_mpc = 10 + _int * 2;
		_mpm = 10 + _int * 2;
		
		ini_write_real("player", "gender", gender_choice);
		ini_write_real("player", "customize", 2);
		ini_write_real("stats", "hp_c", _hpc);
		ini_write_real("stats", "hp_m", _hpm);
		ini_write_real("stats", "mp_c", _mpc);
		ini_write_real("stats", "mp_m", _mpm);
		ini_write_real("stats", "vit", _vit);
		ini_write_real("stats", "end", _end);
		ini_write_real("stats", "str", _str);
		ini_write_real("stats", "int", _int);
		ini_write_real("stats", "dex", _dex);
		ini_write_real("stats", "agi", _agi);
		ini_close();
		
		
		
		buffer_seek(server_buffer,buffer_seek_start,0);
		buffer_write(server_buffer,buffer_u8,network.after_creation);
		buffer_write(server_buffer,buffer_u8,socket);
		buffer_write(server_buffer,buffer_string,_username);
		network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		
		
		network_player_join(_username, 128, 128, "rm_client");
		
		
		break;
	
		
		
		
		
		break;
		
	case network.second_update:
		var _username = buffer_read(buffer,buffer_string);
		var target = global.directory + "\\users\\" + _username + ".ini"
		ini_open(target);
		give_class = ini_read_string("stats", "class", global.string);
		give_level = ini_read_real("stats", "level", global.integer);
		give_hpc = ini_read_real("stats", "hp_c", global.integer);
		give_hpm = ini_read_real("stats", "hp_m", global.integer);
		give_expc = ini_read_real("stats", "exp_c", global.integer);
		give_expm = ini_read_real("stats", "exp_m", global.integer);
		give_vit = ini_read_real("stats", "vit", global.integer);
		give_end = ini_read_real("stats", "end", global.integer);
		give_str = ini_read_real("stats", "str", global.integer);
		give_int = ini_read_real("stats", "int", global.integer);
		give_dex = ini_read_real("stats", "dex", global.integer);
		give_agi = ini_read_real("stats", "agi", global.integer);
		ini_close();
		
		buffer_seek(server_buffer,buffer_seek_start,0);
		buffer_write(server_buffer,buffer_u8,network.second_update);
		buffer_write(server_buffer,buffer_string,give_class);
		buffer_write(server_buffer,buffer_u8,give_level);
		buffer_write(server_buffer,buffer_u16,give_hpc);
		buffer_write(server_buffer,buffer_u16,give_hpm);
		buffer_write(server_buffer,buffer_u16,give_expc);
		buffer_write(server_buffer,buffer_u16,give_expm);
		buffer_write(server_buffer,buffer_u8,give_vit);
		buffer_write(server_buffer,buffer_u8,give_end);
		buffer_write(server_buffer,buffer_u8,give_str);
		buffer_write(server_buffer,buffer_u8,give_int);
		buffer_write(server_buffer,buffer_u8,give_dex);
		buffer_write(server_buffer,buffer_u8,give_agi);
		buffer_write(server_buffer,buffer_u8,socket);
		network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		
		
		var i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list,i)
			if socket != _sock {
				
				if ds_map_exists(socket_to_instanceid,_sock) {
					
			
					buffer_seek(server_buffer,buffer_seek_start,0);
					buffer_write(server_buffer,buffer_u8,network.second_update_other);
					buffer_write(server_buffer,buffer_u8,socket);
					buffer_write(server_buffer,buffer_u16,give_hpc);
					buffer_write(server_buffer,buffer_u16,give_hpm);
					network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
				}
				
			}
			
			i++
		}
		break;
		
	case network.player_new:
		
		var input_username = buffer_read(buffer,buffer_string);
		var input_password = buffer_read(buffer,buffer_string);
		
		var target = global.directory + "\\users\\" + input_username + ".ini"
		
		if file_exists(target) {//invalid username or already taken
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.player_new_fail);
				buffer_write(server_buffer,buffer_u8,socket);
				network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		}
		
		if file_exists(target) == false {
			
				
			ini_open(target);
			ini_write_string("player", "username", input_username);
			ini_write_string("player", "password", input_password);
			ini_write_real("player", "gender", 1);
			ini_write_real("player", "customize", 1);
			ini_write_string("stats", "class", "Wanderer");
			ini_write_real("stats", "level", 1);
			ini_write_real("stats", "exp_c", 0);
			ini_write_real("stats", "exp_m", 10);
			ini_write_real("stats", "hp_c", 10);
			ini_write_real("stats", "hp_m", 10);
			ini_write_real("stats", "vit", 1);
			ini_write_real("stats", "end", 1);
			ini_write_real("stats", "str", 1);
			ini_write_real("stats", "int", 1);
			ini_write_real("stats", "dex", 1);
			ini_write_real("stats", "agi", 1);
			ini_close()
			
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.player_new);
			buffer_write(server_buffer,buffer_u8,socket);
			network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
			
		}
		
		break;
	
	case network.player_login:
		var input_username = buffer_read(buffer,buffer_string);
		var input_password = buffer_read(buffer,buffer_string);
		
		var target = global.directory + "\\users\\" + input_username + ".ini"
		
		if file_exists(target) {
			ini_open(target);
			var check_password = ini_read_string("player", "password", global.string)
			var check_custom = ini_read_real("player", "customize", global.integer)
			ini_close()
			
			if input_password == check_password {//proceed to log in
				
				if check_custom == 1 { //if they aren't customized, tell them to customize
					
					buffer_seek(server_buffer,buffer_seek_start,0);
					buffer_write(server_buffer,buffer_u8,network.make_character);
					buffer_write(server_buffer,buffer_string,input_username);
					buffer_write(server_buffer,buffer_u8,socket);
					network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
				}
				else //if they are already customized, then log them in
					network_player_join(input_username, 128, 128, "rm_client");
					
			}
			
			if input_password != check_password {//fail to log in
					
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.player_login_fail);
				buffer_write(server_buffer,buffer_u8,socket);
				network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
	
			}
		
		}
		else {//fail to log in
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.player_login_fail);
				buffer_write(server_buffer,buffer_u8,socket);
				network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		}
		
		break;
	//case network.player_establish:
	////moved up to network.player_login
		
	//	break;
	
	case network.move: 
		var all_clear = buffer_read(buffer,buffer_string);
		var move_direction = buffer_read(buffer,buffer_u8);
		var move_x = buffer_read(buffer,buffer_u16);
		var move_y = buffer_read(buffer,buffer_u16);
		
		//turn the player first
		
		
		var i = 0;
		repeat(ds_list_size(socket_list))
		{
			
			var _sock = ds_list_find_value(socket_list,i)
			
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.turn)
			buffer_write(server_buffer,buffer_u8,socket);
			buffer_write(server_buffer,buffer_u8,move_direction)
			network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
			i++
		}
		
		
		if all_clear == true {
			var _player = ds_map_find_value(socket_to_instanceid,socket)
			_player.x = move_x;
			_player.y = move_y;
		
			var i = 0;
			repeat(ds_list_size(socket_list))
			{
			
				var _sock = ds_list_find_value(socket_list,i)
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.move)
				buffer_write(server_buffer,buffer_u8,socket);
				buffer_write(server_buffer,buffer_u16,move_x);
				buffer_write(server_buffer,buffer_u16,move_y);
				network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
				i++
			}
		}
		
		
		
		break;
		
	case network.chat:
		var _chat = buffer_read(buffer,buffer_string);
		var _player = ds_map_find_value(socket_to_instanceid,socket)
		var _listing = "";
		
		_chat = _player.username+": "+_chat;
		
		// Message formatting for line efficiency
		if string_length(_chat) < 33 {
			ds_list_insert(global.chat,0,_chat);
			ds_list_insert(global.chat_color,0,c_white);
		}
		
		
		if string_length(_chat) >= 33 and string_length(_chat) < 65{
			_listing = string_copy(_chat,1,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_white);
			
			_listing = string_copy(_chat,33,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_white);
		}
		
		if string_length(_chat) >= 65 {
			_listing = string_copy(_chat,1,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_white);
			
			_listing = string_copy(_chat,33,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_white);
			
			_listing = string_copy(_chat,65,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_white);
		}
		
		
		//Send chat to all players in the socket list
		var i = 0;
		repeat(ds_list_size(socket_list))
		{
			
			var _sock = ds_list_find_value(socket_list,i)
			
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.chat)
			buffer_write(server_buffer,buffer_string,_chat);
			buffer_write(server_buffer,buffer_u8,1);
			network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		
			
			i++
		}
		
		break;
		
		
}



a_bot_setlist();
}
