if select == 1 {
	if menu == 1 {
		menu = 2;
		keyboard_string = "";
		input_username = "";
		input_password = "";
	}
}

if select == 2 {
	if menu == 1 {
		menu = 3;
		keyboard_string = "";
		input_username = "";
		input_password = "";
	}
}

#region Attempt to log in
if menu == 2 {
	//initialize flags
	user_OK = true; 
	pass_OK = true;
	//
	//finalizing the inputs
	if select == 1
		input_username = keyboard_string;
	
	if select == 2
		input_password = keyboard_string;
	//
	//declining if either entry field is empty
	if string_length(input_username) == 0
		user_OK = false;
		
	if string_length(input_password) == 0
		user_OK = false;
	//
	//
	if user_OK == true and pass_OK == true	{ //valid credentials
			
		
		instance_destroy(obj_slave);
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.player_login);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,input_username);
		buffer_write(con_client.client_buffer,buffer_string,input_password);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

	}
}
#endregion

#region Attempt to create a new account
if menu == 3 {
	//initialize flags
	user_OK = true; 
	pass_OK = true;
	//
	//finalizing the inputs
	if select == 1
		input_username = keyboard_string;
	
	if select == 2
		input_password = keyboard_string;
	//
	//declining if either entry field is empty
	if string_length(input_username) == 0
		user_OK = false;
		
	if string_length(input_password) == 0
		user_OK = false;
	//
	//
	if user_OK == true and pass_OK == true	{ //valid credentials
		
		
		instance_destroy(obj_slave);
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.player_new);
		buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
		buffer_write(con_client.client_buffer,buffer_string,input_username);
		buffer_write(con_client.client_buffer,buffer_string,input_password);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));

	}
}
#endregion
