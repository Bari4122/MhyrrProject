// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_player_join(){
	
	room_name = argument3;
	
	a_top_setlist();
		
	var _username = argument0;
    var place_x = argument1;
	var place_y = argument2;


	var _player = instance_create_depth(place_x,place_y,depth,obj_player);
	_player.username = _username; //Give player their username
	
	//Add instance id of obj_player to socket map
	ds_map_add(socket_to_instanceid,socket,_player); 
	
	ini_open(global.directory + "//users//" + _username + ".ini");
	var _gender = ini_read_real("player","gender",global.integer);
	var _customize = ini_read_real("player","customize",global.integer);
	ini_close();
		
	#region Create obj_player for connecting client
	buffer_seek(server_buffer,buffer_seek_start,0);
	buffer_write(server_buffer,buffer_u8,network.player_connect);
	buffer_write(server_buffer,buffer_u8,socket);
	buffer_write(server_buffer,buffer_u16,place_x);
	buffer_write(server_buffer,buffer_u16,place_y);
	buffer_write(server_buffer,buffer_u8,_gender);
	buffer_write(server_buffer,buffer_u8,_customize);
	buffer_write(server_buffer,buffer_string,_username);
	buffer_write(server_buffer,buffer_string,room_name);
	network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
	#endregion
	
	#region Load all the existing enemies for the connecting client
	var file = file_text_open_read(global.directory + "//ini_saves//" + room_name + ".ini")
	while (!file_text_eof(file)) {
		var line = file_text_readln(file);
		if string_char_at(line, 1) == "[" and string_char_at(line, 2) != "s" {
			section = line;
			section = string_delete(line, string_length(line)-2, 3);
			section = string_delete(section, 1, 1);
			
			ini_open(global.directory + "//ini_saves//" + room_name + ".ini")
			var _x = ini_read_real(section, "x", global.integer)
			var _y = ini_read_real(section, "y", global.integer)
			var _type = ini_read_string(section, "type", global.string)
			var _aggro = ini_read_string(section, "aggro", global.string)
			var e_hpc = ini_read_real(section, "hp", global.integer)
			ini_close();
			
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.enemy_draw_map_change);
			buffer_write(server_buffer,buffer_u16,_x);
			buffer_write(server_buffer,buffer_u16,_y);
			buffer_write(server_buffer,buffer_string,_type);
			buffer_write(server_buffer,buffer_string,_aggro);
			buffer_write(server_buffer,buffer_u16,e_hpc);
			network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
			
			
		}
	}
	file_text_close(file);
	#endregion
	
	#region Send already joined clients to connecting client
	var i = 0;
	repeat(ds_list_size(socket_list))
	{
			
		var _sock = ds_list_find_value(socket_list,i);
		if _sock != socket
		{
			
			if ds_map_exists(socket_to_instanceid,_sock) {
				var _slave = ds_map_find_value(socket_to_instanceid,_sock);
				
				ini_open(global.directory + "//users//" + _slave.username + ".ini");
				var _gender = ini_read_real("player","gender",global.integer);
				ini_close();
			
				buffer_seek(server_buffer,buffer_seek_start,0);
				buffer_write(server_buffer,buffer_u8,network.player_joined);
				buffer_write(server_buffer,buffer_u8,_sock);
				buffer_write(server_buffer,buffer_u16,_slave.x);
				buffer_write(server_buffer,buffer_u16,_slave.y);
				buffer_write(server_buffer,buffer_u8,_gender);
				buffer_write(server_buffer,buffer_string,_slave.username);
				network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
				
			}
			
		}
			
		i+=1;
	}
	#endregion
		
	#region Send the client that just joined to the clients already in game
	
	ini_open(global.directory + "//users//" + _player.username + ".ini");
	var _gender = ini_read_real("player","gender",global.integer);
	ini_close();
	
	var i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list,i);
		if _sock != socket
		{
				
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.player_joined);
			buffer_write(server_buffer,buffer_u8,socket);
			buffer_write(server_buffer,buffer_u16,_player.x);
			buffer_write(server_buffer,buffer_u16,_player.y);
			buffer_write(server_buffer,buffer_u8,_gender);
			buffer_write(server_buffer,buffer_string,_player.username);
			network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));

		}
		i = i + 1;
	}
	#endregion

	
	a_bot_setlist();
	
}