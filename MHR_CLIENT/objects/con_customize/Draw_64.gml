draw_set_font(fnt_game);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_sprite(spr_customize_background, 1, box_x, box_y);

if select == 1
	draw_sprite(spr_selector, 1, box_x + 70, box_y + 205);
	
if select == 6
	draw_sprite(spr_selector, 1, box_x + 70, box_y + 500);

if select == 7
	draw_sprite(spr_selector, 1, box_x + 70, box_y + 645);


draw_set_color(c_black);
draw_text(box_x + 100, box_y + 62, "Name: " + global.username);
draw_text(box_x + 100, box_y + 135, "Class: " + class);
if gender_choice = 1 {
	draw_text(box_x + 100, box_y + 205, "Gender: Male");
	draw_sprite(spr_wanderer_male, frame, box_x + 550, box_y + 160);
}
else {
	draw_text(box_x + 100, box_y + 205, "Gender: Female");
	draw_sprite(spr_wanderer_female, frame, box_x + 550, box_y + 160);
}

if personality_choice == 1 {
	draw_text(box_x + 100, box_y + 500, "Personality: Brave");
	add_vit = 1;
	add_end = 0;
	add_str = 2;
	add_int = 0;
	add_dex = 0;
	add_agi = 0;
}

if personality_choice == 2 {
	draw_text(box_x + 100, box_y + 500, "Personality: Witty");
	add_vit = 0;
	add_end = 0;
	add_str = -1;
	add_int = 2;
	add_dex = 2;
	add_agi = 0;
}

if personality_choice == 3 {
	draw_text(box_x + 100, box_y + 500, "Personality: Headstrong");
	add_vit = 2;
	add_end = 2;
	add_str = 0;
	add_int = -1;
	add_dex = 0;
	add_agi = 0;
}

if personality_choice == 4 {
	draw_text(box_x + 100, box_y + 500, "Personality: Wize");
	add_vit = 0;
	add_end = -1;
	add_str = 0;
	add_int = 4;
	add_dex = 0;
	add_agi = 0;
}

if personality_choice == 5 {
	draw_text(box_x + 100, box_y + 500, "Personality: Nimble");
	add_vit = -1;
	add_end = 0;
	add_str = 0;
	add_int = 0;
	add_dex = 1;
	add_agi = 3;
}

if personality_choice == 6 {
	draw_text(box_x + 100, box_y + 500, "Personality: Crafty");
	add_vit = 0;
	add_end = -1;
	add_str = 0;
	add_int = 0;
	add_dex = 4;
	add_agi = 0;
}

if personality_choice == 7 {
	draw_text(box_x + 100, box_y + 500, "Personality: Shy");
	add_vit = -1;
	add_end = -1;
	add_str = -1;
	add_int = 2;
	add_dex = 2;
	add_agi = 2;
}

draw_text(box_x + 430, box_y + 520, "VIT: " + string(1 + add_vit));
draw_text(box_x + 430, box_y + 540, "END: " + string(1 + add_end));
draw_text(box_x + 430, box_y + 560, "STR: " + string(1 + add_str));
draw_text(box_x + 430, box_y + 580, "INT: " + string(1 + add_int));
draw_text(box_x + 430, box_y + 600, "DEX: " + string(1 + add_dex));
draw_text(box_x + 430, box_y + 620, "AGI: " + string(1 + add_agi));

draw_text(box_x + 140, box_y + 645, "Play!");

