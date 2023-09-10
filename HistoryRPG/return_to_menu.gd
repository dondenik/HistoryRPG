extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Inventory.player_inventory = {"selected_items": {"Fist": {"action": {"type": "attack","value": 3,"mods": ["ignoreDefence"], "name": "Punch", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Punch!", "texture": ""}, "Leg": {"action": {"type": "attack","value": 1,"mods": ["evade"], "name": "Run", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Run!", "texture": ""}, "Time Machine": {"action": {"type": "attack","value": 2,"mods": ["freeze"], "name": "Time Freeze", "crit_chance": 0}, "passive": {"name": "Modern Casing", "defence": 2, "damage": 0, "passive_status": ""}, "tooltip": "Time Blast!", "texture": ""}, "Modern Tech": {"action": {"type": "attack","value": 1,"mods": ["weaken"], "name": "Confuse", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Confusion!", "texture": ""}}}
	Inventory.health = 100
	Inventory.unlocked_items = {}
	Inventory.gold = 0
	get_tree().change_scene_to_file("res://main_menu.tscn")
