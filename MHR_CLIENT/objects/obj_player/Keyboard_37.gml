if held_down < 30
	held_down += 2

if can_move == true and held_down == 30 {
	held_down = 20
	obj_player_run_left()
}
