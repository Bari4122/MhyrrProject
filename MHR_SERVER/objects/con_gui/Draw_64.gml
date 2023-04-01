draw_set_halign(fa_left);
draw_set_valign(fa_middle);

//Draw out chatroom
for(var i = 0; i<chatSize;i++) 
{
	draw_set_color(ds_list_find_value(global.chat_color,i));
	draw_text(20,700-(16*i),ds_list_find_value(global.chat,i))
}
if active = true
{	
	while string_length(display_text) > 32 {
		display_text = string_delete(display_text,1,1)
	}
	
	if string_length(keyboard_string) > 96 {
		display_text = string_delete(display_text,97,1)
		keyboard_string = string_delete(keyboard_string,97,1)
	}
	draw_set_color(c_lime);
	draw_text(20,740,"> "+display_text);
}
else
{
	draw_set_color(c_gray);
	draw_text(20,740,"> ");
}