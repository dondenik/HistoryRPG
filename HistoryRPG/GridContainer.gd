extends GridContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	for inv_item_name in Inventory.unlocked_items:
		var x = item.new()
		x.custom_minimum_size = Vector2(192, 192)
		x.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		x.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		x.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		x.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		self.add_child(x)
		var inv_item = Inventory.unlocked_items[inv_item_name]
		var tex = inv_item.texture
		var tooltip = inv_item.tooltip
		var type = inv_item.action.type
		x.update_item(inv_item, tex, tooltip, inv_item_name, type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
