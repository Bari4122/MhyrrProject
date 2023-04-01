enum network 
{
	player_login,
	player_login_fail,
	player_new,
	player_new_fail,
	player_connect,
	player_joined,
	player_disconnect,
	player_attack,
	skip_customize,
	second_update,
	second_update_other,
	move,
	turn,
	chat,
	make_character,
	after_creation,
	enemy_take_damage,
	enemy_die,
	add_to_console,
	enemy_movement,
	player_teleport,
	player_remake,
	player_switch_room,
	enemy_spawn,
	enemy_draw_map_change,
	enemy_attack,
}



global.wall_list = ds_list_create();
ds_list_add(global.wall_list,"wall_block");

client = network_create_socket(network_socket_tcp);
network_connect(client, "25.58.55.254",65111);

client_buffer = buffer_create(1024,buffer_fixed,1);

socket_to_instanceid = ds_map_create();