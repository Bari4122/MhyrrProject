if select == 1 {
	select = 2;
	if menu != 1
		input_username = keyboard_string;
		keyboard_string = input_password;
}
else {
	select = 1;
	if menu != 1
		input_password = keyboard_string;
		keyboard_string = input_username;
}