extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Current Health: " + str(Inventory.health)
	$Label2.text = "Projected Health: " + str(clamp(Inventory.health + int(Inventory.gold ** 1.2) * 10, 0, 100)) + " (" + str(int(Inventory.gold ** 1.2) * 10) +")"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Inventory.health = clamp(Inventory.health + int(Inventory.gold ** 1.2) * 10, 0, 100)
	Inventory.gold = 0
	$Label.text = "Current Health: " + str(Inventory.health)
	$Label2.text = "Projected Health: " + str(clamp(Inventory.health + int(Inventory.gold ** 1.2) * 10, 0, 100)) + " (" + str(int(Inventory.gold ** 1.2) * 10) +")"
