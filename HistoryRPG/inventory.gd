extends Node

var player_inventory = {"selected_items": {"Golden Sword": {"action": {"type": "attack","value": 5,"mods": ["freeze"], "name": "Golden cut", "crit_chance": 15}, "passive": {"name": "Golden Glimmer", "defence": 4, "damage": 0, "passive_status": ""}, "tooltip": "tooltip", "texture": "res://ea-nasir.jpeg"}}}
var enemy_inventory = {"selected_items": {"Golden Sword": {"action": {"type": "attack","value": 5,"mods": ["freeze"], "name": "Golden cut", "crit_chance": 15}, "passive": {"name": "Golden Glimmer", "defence": 4, "damage": 0, "passive_status": ""}, "tooltip": "tooltip", "texture": "res://ea-nasir.jpeg"}}}
var unlocked_items = {"Golden Sword": {"action": {"type": "attack","value": 5,"mods": ["ignoreDefence"], "name": "Golden cut", "crit_chance": 15}, "passive": {"name": "Golden Glimmer", "defence": 4, "damage": 0, "passive_status": ""}, "tooltip": "tooltip", "texture": "res://ea-nasir.jpeg"}}
var health = 100
var gold = 0
var enemy_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
