spawn_x = x;
spawn_y = y-64;
enemy_name = "enm_slime_green";

buffer_seek(con_client.client_buffer,buffer_seek_start,0);
buffer_write(con_client.client_buffer,buffer_u8,network.enemy_spawn);
buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
buffer_write(con_client.client_buffer,buffer_u16,spawn_x);
buffer_write(con_client.client_buffer,buffer_u16,spawn_y);
buffer_write(con_client.client_buffer,buffer_string,enemy_name);
network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
