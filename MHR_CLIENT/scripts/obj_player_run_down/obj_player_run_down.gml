function obj_player_run_down(){
obj_player.check_x = obj_player.x;
obj_player.check_y = obj_player.y;
obj_player.check_x += 32;
obj_player.check_y += 32;

obj_player.check_y = obj_player.check_y + 64;

var move_direction = 3;
obj_player_run(move_direction);
}