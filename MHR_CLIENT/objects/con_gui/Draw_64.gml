draw_set_font(fnt_game);
//base
draw_sprite(spr_gui,1, 0,860);

//health bar
hp_bar = hp_m / 10;
#region Setting the frame for the health bar
if hp_c == hp_m
	health_bar = 0
	
if hp_c < hp_m
	health_bar = 1
	
if hp_c <= hp_bar * 8
	health_bar = 2
	
if hp_c <= hp_bar * 7
	health_bar = 3
	
if hp_c <= hp_bar * 6
	health_bar = 4
	
if hp_c <= hp_bar * 5
	health_bar = 5
	
if hp_c <= hp_bar * 4
	health_bar = 6
	
if hp_c <= hp_bar * 3
	health_bar = 7
	
if hp_c <= hp_bar * 2
	health_bar = 8
	
if hp_c <= hp_bar * 1
	health_bar = 9
	
if hp_c < 1
	health_bar = 10
#endregion

draw_sprite(spr_big_health_bar,health_bar, 330, 870);

//character sheet
if character_sheet = 0
	draw_sprite(spr_character_hotkey_off,1, 361,987)
if character_sheet = 1 {
	draw_sprite(spr_character_hotkey_on,1, 361,987)
	//background for sheet
	draw_sprite(spr_character_sheet,1, cs_x,cs_y)
	//set align
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	//username
	draw_text(cs_x + 105,cs_y + 80,global.username)
	//class
	draw_text(cs_x + 105,cs_y + 100, class)
	//level
	draw_text(cs_x + 105,cs_y + 140,  "Level: " + string(level))
	//exp
	draw_text(cs_x + 105,cs_y + 160, string(exp_c) + " / " + string(exp_m))
	//vit
	draw_text(cs_x + 105,cs_y + 192, "VIT: " + string(vit))
	//end
	draw_text(cs_x + 105,cs_y + 221, "END: " + string(endu))
	//str
	draw_text(cs_x + 105,cs_y + 249, "STR: " + string(str))
	//int
	draw_text(cs_x + 105,cs_y + 277, "INT: " + string(int))
	//dex
	draw_text(cs_x + 105,cs_y + 305, "DEX: " + string(dex))
	//agi
	draw_text(cs_x + 105,cs_y + 334, "AGI: " + string(agi))
	
	
	
}
	
	
	


