if select == 7 {
	
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.make_character);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,global.username);
		buffer_write(con_client.client_buffer,buffer_u8,gender_choice);
		buffer_write(con_client.client_buffer,buffer_u8,personality_choice);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
		
}