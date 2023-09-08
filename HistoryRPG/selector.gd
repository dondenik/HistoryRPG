extends Control
@onready var slots = [$TextureRect, $TextureRect2, $TextureRect3, $TextureRect4]
var num_tweens_done = 0
var current_enemy_index = 0
var enemies = Inventory.enemies
var in_progress = false
var enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	# set slots to 2023 and remove finished coloring
	set_slots("2023", "AD", 100.0, false)
	self.in_progress = false
	

func set_slot_position(value, slot):
	slot.set_position(Vector2(slot.position.x, value - 344))
	
func slot_tween(slot, num, time, do_coloring, ce):
	var tween = create_tween()
	tween.connect("finished", tween_done.bind(ce)) if do_coloring else 0
	tween.tween_method(set_slot_position.bind(slots[slot]), 0, 92.6 * (9 - num), time)

func set_slots(num, ce, time_mod=1.5, do_coloring=true):
	self.in_progress = true
	for i in range(4):
		slot_tween(i, int(num[i]), ((abs(i - 4) + 0.1) / time_mod), do_coloring, ce)
	$TextureRect.material.set_shader_parameter("blue_colorise", false)
	$TextureRect2.material.set_shader_parameter("blue_colorise", false)
	$TextureRect3.material.set_shader_parameter("blue_colorise", false)
	$TextureRect4.material.set_shader_parameter("blue_colorise", false)
		
func tween_done(ce):
	num_tweens_done += 1
	if num_tweens_done > 3:
		num_tweens_done = 0
		$TextureRect.material.set_shader_parameter("blue_colorise", true)
		$TextureRect2.material.set_shader_parameter("blue_colorise", true)
		$TextureRect3.material.set_shader_parameter("blue_colorise", true)
		$TextureRect4.material.set_shader_parameter("blue_colorise", true)
		self.in_progress = false
		$ad_bc.text = ce
		$EnemyPreview/TextureRect.texture = load(enemy.texture)
		$EnemyPreview/difficulty_label.text = "Difficulty: " + enemy.difficulty
		$EnemyPreview/name_label.text = enemy.name
		$EnemyPreview/rewards_label.text = "Rewards: " + str(enemy.rewards) + " Gold + " + enemy.actions.selected_items.keys()[0]
	

func switch_enemy(enemy_index):
	enemy = self.enemies[enemy_index]
	set_slots(enemy.date, enemy.ce)
	Inventory.enemy_inventory = enemy.actions
	Inventory.enemy_texture = enemy.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_up_pressed():
	if not self.in_progress:
		if current_enemy_index < len(enemies) - 1:
			current_enemy_index += 1
		else:
			current_enemy_index = 0
		switch_enemy(current_enemy_index)


func _on_down_pressed():
	if not self.in_progress:
		if current_enemy_index > 0:
			current_enemy_index -= 1
		else:
			current_enemy_index = len(enemies) - 1
		switch_enemy(current_enemy_index)


func _on_battle_pressed():
	get_tree().change_scene_to_file("res://battle.tscn")


func _on_inventory_button_pressed():
	get_tree().change_scene_to_file("res://inventory.tscn")
