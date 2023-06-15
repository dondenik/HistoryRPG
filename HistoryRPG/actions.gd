extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("action_buttons"):
		button.pressed.connect(_on_pressed.bind(button))

func _on_pressed(button):
	print(button.name, " was pressed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
