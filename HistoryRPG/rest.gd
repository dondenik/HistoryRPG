extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var player = get_node("../../Player")
	player.health = clamp(player.health + 8, 0, 100)
	player.update_health_bar(player.health)
	player.turn_finished.emit()
