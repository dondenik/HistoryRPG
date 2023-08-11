extends TextureRect

@export var type = ""
var inv_item_name = ""
var inv_item = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _drop_data(at_position, data):
	self.texture = data.texture
	self.tooltip_text = data.tooltip_text
	Inventory.player_inventory.selected_items.erase(self.inv_item_name)
	self.inv_item = data.inv_item
	self.inv_item_name = data.inv_item_name
	Inventory.player_inventory.selected_items[self.inv_item_name] = self.inv_item

func _can_drop_data(at_position, data):
	if data.type == self.type:
		return true
	else:
		return false
