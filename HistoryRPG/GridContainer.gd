extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for inv_item_name in Inventory.unlocked_items:
		var x = item.new()
		self.add_child(x)
		var inv_item = Inventory.unlocked_items[inv_item_name]
		var tex = load("res://ea-nasir.jpeg")
		var tooltip = "TIPPIP"
		x.update_item(inv_item, tex, tooltip, inv_item_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
