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
var weaken_value = 0
var evade_value = 0
var intimidate_value = 0

var status_effects_list = {"undermine":undermine, "bleed":bleed, "weaken":weaken, "evade":evade, "intimidate":intimidate}

var inventory = Inventory.player_inventory

func undermine():
	status_effects_to_remove.append("undermine")
	if not rng.randi_range(0,2):
		return "skip"

func bleed():
	status_effects_to_remove.append("bleed")
	if not rng.randi_range(0,2):
		self.health -= 1
		self.update_health_bar(self.health)

func weaken():
	status_effects_to_remove.append("weaken")
	weaken_value = 3

func evade():
	status_effects_to_remove.append("evade")
	evade_value = 1

func intimidate():
	status_effects_to_remove.append("intimidate")
	intimidate_value = 1

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
			if passive.passive_status != "":
				status_effects.append(passive.passive_status)
	button_renaming.emit(actions)
	update_health_bar(self.health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var status_string = ""
	for effect in status_effects:
		status_string = status_string + "+" + effect + "\n"
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
	
	if value < weaken_value:
		value = 1
	else:
		value -= weaken_value
	if value < intimidate_value:
		value = 1
	else:
		value -= intimidate_value
	if crit_chance < intimidate_value * 10:
		crit_chance = 0
	else:
		crit_chance -= 10
	if evade_value:
		crit_chance = 0
	
	action.emit(type, value, mods, name, crit_chance)
	turn_finished.emit()


func _on_enemy_action(type, value, mods, name, crit_chance):
	# remove old status effects
	for effect in status_effects_to_remove:
		status_effects.erase(effect)
		evade_value = 0
		intimidate_value = 0
		weaken_value = 0
	status_effects_to_remove = []
	self.health -= calculate_mods(mods, value, type, name, crit_chance)
	print("HEALTH ", health)
	if self.health < 1 and get_node("../Enemy").health > 0:
		die()
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
		if damage > defence:
			damage -= defence
		else:
			damage = 0
	if crit_chance >= rng.randi_range(0, 99):
		return damage * 2
	else:
		return damage

func update_health_bar(health):
	Inventory.health = health
	var adjusted_health = health / 100.0
	get_parent().get_node("ColorRect").material.set_shader_parameter("HealthAmount", adjusted_health)

func die():
	get_tree().change_scene_to_file("res://dead.tscn")

func _on_control_player_turn():
	var skip: bool
	for status_effect in status_effects:
		if status_effect != "":
			if status_effects_list[status_effect].call() == "skip":
				skip = true
	if skip == true:
		turn_finished.emit()
		
