function obj_player_run_up(){
obj_player.check_x = obj_player.x;
obj_player.check_y = obj_player.y;
obj_player.check_x += 32;
obj_player.check_y += 32;

obj_player.check_y = obj_player.check_y - 64;

var move_direction = 1;

obj_player_run(move_direction);
}