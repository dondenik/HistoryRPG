extends Control
@onready var slots = [$TextureRect, $TextureRect2, $TextureRect3, $TextureRect4]
var num_tweens_done = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_slots([9,9,9,9])

	

func set_slot_position(value, slot):
	slot.set_position(Vector2(slot.position.x, value - 344))
	
func slot_tween(slot, num, time):
	var tween = create_tween()
	tween.connect("finished", tween_done)
	tween.tween_method(set_slot_position.bind(slots[slot]), 0, 92.6 * (9 - num), time)

func set_slots(num):
	for i in range(4):
		print(num[i])
		slot_tween(i, num[i], (i + 0.5))
	$TextureRect.material.set_shader_parameter("blue_colorise", false)
	$TextureRect2.material.set_shader_parameter("blue_colorise", false)
	$TextureRect3.material.set_shader_parameter("blue_colorise", false)
	$TextureRect4.material.set_shader_parameter("blue_colorise", false)
		
func tween_done():
	num_tweens_done += 1
	if num_tweens_done >= 4:
		num_tweens_done = 0
		$TextureRect.material.set_shader_parameter("blue_colorise", true)
		$TextureRect2.material.set_shader_parameter("blue_colorise", true)
		$TextureRect3.material.set_shader_parameter("blue_colorise", true)
		$TextureRect4.material.set_shader_parameter("blue_colorise", true)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass 
