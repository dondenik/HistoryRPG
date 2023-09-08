extends TextureRect
class_name item

var type = "hand"
var inv_item
var tex
var inv_item_name


# Called when the node enters the scene tree for the first time.
func _ready():
	#self.texture = load("res://ea-nasir.jpeg")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _get_drag_data(at_position):
	set_drag_preview(self.duplicate())
	return self

func update_item(inv_item, tex, tooltip, inv_item_name, type):
	self.tooltip_text = tooltip
	self.texture = load(tex)
	self.inv_item  = inv_item
	self.inv_item_name = inv_item_name
	self.type = type
