// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function a_top_setlist(){
	
	if room_name == "rm_client"
		ds_list_copy(socket_list, SL_rmclient);
	if room_name == "rm_field01"
		ds_list_copy(socket_list, SL_rmfield01);
}