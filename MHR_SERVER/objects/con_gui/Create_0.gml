global.chat = ds_list_create();
global.chat_color = ds_list_create();

ds_list_add(global.chat,"SERVER LAUNCH SUCCESS","ALPHA","","","");
ds_list_add(global.chat_color,c_red,c_red,c_white,c_white,c_white);

active = false; //on and off switch
chatSize = 5; //how many chat messages
chat_text = ""; //chat message

