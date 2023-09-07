extends Node2D

signal action(type, value, mods, name, crit_chance)
signal button_renaming(actions)
signal turn_finished

var actions = {}
var health = Inventory.health
var passives = {}
var items
var status_effects = []
var status_effects_to_remove = []
var rng = RandomNumberGenerator.new()

var status_effects_list = {"freeze":freeze, "john":john}

var inventory = Inventory.player_inventory

func freeze():
	status_effects_to_remove.append("freeze")
	if not rng.randi_range(0,5):
		return "skip"
	
func john():
	print("JOHnned")

func _ready():
	items = inventory.selected_items
	items = Dictionary(items)
	for item in items:
		if items[item] != null:
			item = Dictionary(items[item])
			var action = Dictionary(item["action"])
			actions[action["name"]] = action
			var passive = Dictionary(item["passive"])
			passives[passive["name"]] = passive
			status_effects.append(passive.passive_status)
	button_renaming.emit(actions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var status_string = ""
	for effect in status_effects:
		status_string = status_string + "\n" + effect
	$Label.text = status_string


func _on_grid_container_button_pressed(name):
	check_action(name)


func check_action(name):
	if name in actions:
		mod_action(actions[name])


func mod_action(action_details):
	var type = action_details.type
	var value = action_details.value
	var mods = action_details.mods
	var name = action_details.name
	var crit_chance = action_details.crit_chance
	action.emit(type, value, mods, name, crit_chance)
	turn_finished.emit()


func _on_enemy_action(type, value, mods, name, crit_chance):
	# remove old status effects
	for effect in status_effects_to_remove:
		status_effects.erase(effect)
	status_effects_to_remove = []
	self.health -= calculate_mods(mods, value, type, name, crit_chance)
	update_health_bar(self.health)

func calculate_mods(mods, value, type, name, crit_chance):
	var damage: int
	var defence: int
	# apply status effects
	for mod in mods:
		if mod in status_effects_list and "ignore" not in mod:
			status_effects.append(mod)
	damage = value
	if "ignoreDefence" not in mods:
		for passive in passives:
			defence += passives[passive].defence
		damage -= defence
	if crit_chance >= rng.randi_range(0, 99):
		return damage * 2
	else:
		return damage

func update_health_bar(health):
	var adjusted_health = health / 100.0
	get_parent().get_node("ColorRect").material.set_shader_parameter("HealthAmount", adjusted_health)


func _on_control_player_turn():
	var skip: bool
	for status_effect in status_effects:
		if status_effect != "":
			if status_effects_list[status_effect].call() == "skip":
				skip = true
	if skip == true:
		turn_finished.emit()
		
