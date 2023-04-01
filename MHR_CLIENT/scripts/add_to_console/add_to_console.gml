function add_to_console(_message){
	
	
	
	if string_length(_message) < 33
		ds_list_insert(global.console,0,_message);
			
	if string_length(_message) >= 33 and string_length(_message) < 65 {
		_addition = string_copy(_message,1,32);
		ds_list_insert(global.console,0,_addition);
		_addition = string_copy(_message,33,32);
		ds_list_insert(global.console,0,_addition);
	}
	
	if string_length(_message) >= 65 {
		_addition = string_copy(_message,1,32);
		ds_list_insert(global.console,0,_addition);
		_addition = string_copy(_message,33,32);
		ds_list_insert(global.console,0,_addition);
		_addition = string_copy(_message,65,32);
		ds_list_insert(global.console,0,_addition);
	}				
}