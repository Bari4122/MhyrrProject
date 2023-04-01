draw_set_font(fnt_game);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

if fail == 1 {
	
	success = 0;
	draw_set_color(c_red);
	draw_text(512 - 250, 512 + 140, "Username or password invalid. Please try again.");
	draw_set_color(c_white);
}

if fail == 2 {

	success = 0;
	draw_set_color(c_red);
	draw_text(512 - 275, 512 + 140, "Username is taken or invalid. Please try a different one.");
	draw_set_color(c_white);
}

if success == 1 {
	fail = 0;
	draw_set_color(c_lime);
	draw_text(512 - 310, 512 + 140, "Account successfully created! Please proceed to log in from the main menu");
	draw_set_color(c_white);
}

if menu == 1 {
	draw_text(512 - 70, 512 + 220, "NEW");
	draw_text(512 - 70, 512 + 200, "LOGIN");
}

if menu == 2
	draw_text(512 - 70, 512 + 160, "LOGIN");
	
if menu == 3
	draw_text(512 - 70, 512 + 160, "NEW");
	
if menu == 2 or menu == 3{
	if select == 1 {
		draw_text(512 - 70, 512 + 200, "Username: " + keyboard_string);
		draw_text(512 - 70, 512 + 220, "Password: " + input_password);
	}
	if select == 2 {
		draw_text(512 - 70, 512 + 200, "Username: " + input_username);
		draw_text(512 - 70, 512 + 220, "Password: " + keyboard_string);
	}
}

if blink == 1 {
	draw_text(512 - 100, 512 + 400,"Press ENTER to confirm");
	if menu > 1
		draw_text(512 - 100, 512 + 420,"Press DELETE to go back");
}

if select == 1 
	draw_sprite(spr_selector, 1, 512 - 100, 512 + 200);

if select == 2 
	draw_sprite(spr_selector, 1, 512 - 100, 512 + 220);
