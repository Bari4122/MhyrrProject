// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function a_bot_setlist(){
	
	if room_name == "rm_client"
		ds_list_copy(SL_rmclient, socket_list);
	if room_name == "rm_field01"
		ds_list_copy(SL_rmfield01, socket_list);
}