extends Node2D

signal action(type, value, mods, name, crit_chance)
signal turn_finished

var actions = {}
var health = 100
var passives = {}
var items
var status_effects = []
var rng = RandomNumberGenerator.new()

var status_effects_list = {"Freeze":freeze, "john":john}

# for testing purposes only will later be imported
var inventory = Inventory.enemy_inventory

func freeze():
	print("frozen")
	return "skip"

func john():
	print("JONHNN")

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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func check_action(name):
	if name in actions:
		mod_action(actions[name])


func mod_action(action_details):
	print(action_details)
	var type = action_details.type
	var value = action_details.value
	var mods = action_details.mods
	var name = action_details.name
	var crit_chance = action_details.crit_chance
	action.emit(type, value, mods, name, crit_chance)
	status_effect_graphics_clear()
	turn_finished.emit()


func _on_player_action(type, value, mods, name, crit_chance):
	self.health -= calculate_mods(mods, value, type, name, crit_chance)
	update_health_bar(self.health)

func calculate_mods(mods, value, type, name, crit_chance):
	var damage: int
	var defence: int
	# apply status effects
	for mod in mods:
		print(mod)
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
	var tween = create_tween()
	tween.tween_property(get_parent().get_node("EnemyHealthBar"), "value", health, 0.3).from_current()


func _on_control_enemy_turn():
	var skip: bool = false
	for status_effect in status_effects:
		if status_effect != "":
			if status_effects_list[status_effect].call() == "skip":
				skip = true
	if skip == true:
		turn_finished.emit()

func status_effect_graphics_clear():
	pass

