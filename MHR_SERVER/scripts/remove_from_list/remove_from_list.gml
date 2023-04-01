
function remove_from_list(){
	socket = argument0;
	
	
	if ds_map_exists(socket_to_instanceid,socket) {
			
		with(ds_map_find_value(socket_to_instanceid,socket))
		{
			instance_destroy();	
		}
		
		ds_map_delete(socket_to_instanceid,socket);
	}
	
	ds_list_delete(SL_rmclient,ds_list_find_index(SL_rmclient,socket));
	ds_list_delete(SL_rmfield01,ds_list_find_index(SL_rmfield01,socket));
	
}