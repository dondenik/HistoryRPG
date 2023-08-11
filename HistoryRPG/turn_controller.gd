extends Control

var rng = RandomNumberGenerator.new()
signal player_turn
signal enemy_turn


# Called when the node enters the scene tree for the first time.
func _ready():
	# start the game
	var player_starts = rng.randi_range(1,1)
	if player_starts:
		player_turn.emit()
	else:
		enemy_turn.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_action(type, value, mods, name, crit_chance):
	pass


func _on_enemy_action(type, value, mods, name, crit_chance):
	pass


func _on_player_turn_finished():
	enemy_turn.emit()


func _on_enemy_turn_finished():
	player_turn.emit()
