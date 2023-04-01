if active = false
{
	//Turn the chat on
	active = true
	
	//Clear chat text
	keyboard_string = "";
	chat_text = "";
	display_text = "";
}
else
{
	//Turn the chat off
	active = false
	
	chat_text = "SERVER: "+chat_text;
	var _listing = "";
	
	
		if string_length(chat_text) < 33 {
			ds_list_insert(global.chat,0,chat_text);
			ds_list_insert(global.chat_color,0,c_red);
		}
		
		
		if string_length(chat_text) >= 33 and string_length(chat_text) < 65{
			_listing = string_copy(chat_text,1,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_red);
			
			_listing = string_copy(chat_text,33,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_red);
		}
		
		if string_length(chat_text) > 64 {
			_listing = string_copy(chat_text,1,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_red);
			
			_listing = string_copy(chat_text,33,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_red);
			
			_listing = string_copy(chat_text,65,32);
			ds_list_insert(global.chat,0,_listing);
			ds_list_insert(global.chat_color,0,c_red);
		}
	
		//Send data to clients
		var i = 0;
		repeat(ds_list_size(con_server.socket_list))
		{
			
			var _sock = ds_list_find_value(con_server.socket_list,i)
			
			buffer_seek(con_server.server_buffer,buffer_seek_start,0);
			buffer_write(con_server.server_buffer,buffer_u8,network.chat)
			buffer_write(con_server.server_buffer,buffer_string,chat_text);
			buffer_write(con_server.server_buffer,buffer_u8,2);
			network_send_packet(_sock,con_server.server_buffer,buffer_tell(con_server.server_buffer));
		
		i++;
	}
}
