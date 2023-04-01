depth = -3;
global.chat = ds_list_create();
global.chat_color = ds_list_create();

ds_list_add(global.chat,"Welcome " + global.username + "!","Alpha V0.1","","","","","","################################");
ds_list_add(global.chat_color,c_lime,c_teal,c_white,c_white,c_white,c_white,c_white,c_white);

active = false; //on and off switch
chatSize = 8; //how many chat messages
chat_text = ""; //chat message
