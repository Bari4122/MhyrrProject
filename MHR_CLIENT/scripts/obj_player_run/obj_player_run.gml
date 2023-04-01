function obj_player_run(move_direction){
var all_clear = true;

#region Walls + their descriptions put in the console

if place_meeting(obj_player.check_x,obj_player.check_y,wall_water_deep) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "The water is too deep to swim in...")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_block) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a tree.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_tree1) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a tree.")
}


if place_meeting(obj_player.check_x,obj_player.check_y,wall_tree2) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a tree.")
}


if place_meeting(obj_player.check_x,obj_player.check_y,wall_tree3) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a tree.")
}


if place_meeting(obj_player.check_x,obj_player.check_y,wall_rock1) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a small rock.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_rock2) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a rock.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_rock3) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "You bump into a large rock.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_stump) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "This is a stump from a chopped")
	ds_list_insert(global.console, 0, "tree.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_bush) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "It's a bush. It looks empty.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,wall_bush_with_berries) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "It's a bush with berries!")
}
	
if place_meeting(obj_player.check_x,obj_player.check_y,wall_sign_a) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "The sign says, 'Welcome to the")
	ds_list_insert(global.console, 0, " Forest of Slimes'.")
}

if place_meeting(obj_player.check_x,obj_player.check_y,enm_slime_green) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "A menacing green slime.")
}
if place_meeting(obj_player.check_x,obj_player.check_y,enm_slime_blue) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "A menacing blue slime.")
}
if place_meeting(obj_player.check_x,obj_player.check_y,enm_slime_red) == true {
	all_clear = false;
	ds_list_insert(global.console, 0, "A menacing red slime.")
}
#endregion

if obj_player.can_move == false
	all_clear = false;
else {
	
	obj_player.can_move = false;
	obj_player.alarm[0] = room_speed / 8;
}

if room != rm_file_select or room != rm_customize {
	obj_player.check_x -= 32;
	obj_player.check_y -= 32;
	buffer_seek(con_client.client_buffer,buffer_seek_start,0);
	buffer_write(con_client.client_buffer,buffer_u8,network.move);
	buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
	buffer_write(con_client.client_buffer,buffer_string,all_clear);
	buffer_write(con_client.client_buffer,buffer_u8,move_direction);
	buffer_write(con_client.client_buffer,buffer_u16,check_x);
	buffer_write(con_client.client_buffer,buffer_u16,check_y);
	network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
}
}