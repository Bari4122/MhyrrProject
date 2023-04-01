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
	
		//Send data to server
	if string_length(chat_text) > 0 {
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.chat);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,chat_text);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
	}
}