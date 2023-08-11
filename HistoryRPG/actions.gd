extends GridContainer

signal button_pressed(name)
var players_turn = false

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("action_buttons"):
		button.pressed.connect(_on_pressed.bind(button))


func _on_pressed(button):
	if players_turn:
		print(button.name, " was pressed")
		button_pressed.emit(button.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_button_renaming(actions):
	var i = 0
	while i < len(get_tree().get_nodes_in_group("action_buttons")) and i < len(actions):
		get_tree().get_nodes_in_group("action_buttons")[i].name = actions[actions.keys()[i]].name
		get_tree().get_nodes_in_group("action_buttons")[i].text = actions[actions.keys()[i]].name
		i += 1


func _on_control_player_turn():
	players_turn = true
	print("pleyrs turn")


func _on_control_enemy_turn():
	players_turn = false
	print("enenyms turn")
