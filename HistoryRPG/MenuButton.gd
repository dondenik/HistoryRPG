extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _pressed():
	$PopupPanel.popup_centered()


func _on_quit_to_menu_pressed():
	$QuitToMenu.popup_centered()


func _on_quit_to_desktop_pressed():
	$QuitToDesktop.popup_centered()



	


func _on_quit_to_desktop_confirmed():
	get_tree().quit()


func _on_quit_to_menu_confirmed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
