draw_set_font(fnt_game_small);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

//draw console

draw_set_color(c_grey);

for(var i = 0; i<console_size;i++) 
{
	draw_text(715,1005-(16*i),ds_list_find_value(global.console,i))

}