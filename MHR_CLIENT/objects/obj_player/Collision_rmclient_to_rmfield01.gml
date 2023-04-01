target_location = "rm_field01";

target_x = 64;
target_y = 576;

instance_destroy(obj_slave);
instance_destroy(enm_slime_green);

buffer_seek(con_client.client_buffer,buffer_seek_start,0);
buffer_write(con_client.client_buffer,buffer_u8,network.player_teleport);
buffer_write(con_client.client_buffer,buffer_string,room_get_name(room));
buffer_write(con_client.client_buffer,buffer_string,global.username);
buffer_write(con_client.client_buffer,buffer_string,target_location);
buffer_write(con_client.client_buffer,buffer_u16,target_x);
buffer_write(con_client.client_buffer,buffer_u16,target_y);
network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
