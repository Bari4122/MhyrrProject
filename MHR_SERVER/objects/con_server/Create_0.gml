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

randomize();
global.string = "NULL:String is empty";
global.integer = 0;

global.directory = "C:\\Users\\djmul\\Desktop\\Mhyrr\\";

file_delete(global.directory + "\\ini_saves\\" + "rm_client" + ".ini");
ini_open(global.directory + "\\ini_saves\\" + "rm_client" + ".ini");
ini_write_real("start", "start", 0);
ini_close();

file_delete(global.directory + "\\ini_saves\\" + "rm_field01" + ".ini");
ini_open(global.directory + "\\ini_saves\\" + "rm_field01" + ".ini");
ini_write_real("start", "start", 0);
ini_close();


port = 65111;
max_clients = 12;

network_create_server(network_socket_tcp,port,max_clients);

server_buffer = buffer_create(1024,buffer_fixed,1);

socket_list = ds_list_create();
SL_full = ds_list_create();
SL_rmclient = ds_list_create();
SL_rmfield01 = ds_list_create();

socket_to_instanceid = ds_map_create();

playerSpawn_x = 128;
playerSpawn_y = 128;