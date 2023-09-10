extends Node

var player_inventory = {"selected_items": {"Fist": {"action": {"type": "attack","value": 3,"mods": ["ignoreDefence"], "name": "Punch", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Punch!", "texture": ""}, "Leg": {"action": {"type": "attack","value": 1,"mods": ["evade"], "name": "Run", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Run!", "texture": ""}, "Time Machine": {"action": {"type": "attack","value": 1,"mods": ["freeze", "ignoreDefence"], "name": "Time Freeze", "crit_chance": 0}, "passive": {"name": "Modern Casing", "defence": 2, "damage": 0, "passive_status": ""}, "tooltip": "Time Blast!", "texture": ""}, "Modern Tech": {"action": {"type": "attack","value": 1,"mods": ["weaken"], "name": "Confuse", "crit_chance": 0}, "passive": {"name": "", "defence": 0, "damage": 0, "passive_status": ""}, "tooltip": "Confusion!", "texture": ""}}}
var enemy_inventory = {"selected_items": {"Golden Axe": {"action": {"type": "attack","value": 14,"mods": ["freeze"], "name": "Golden cut", "crit_chance": 0}, "passive": {"name": "Golden Glimmer", "defence": 4, "damage": 0, "passive_status": ""}, "tooltip": "tooltip", "texture": "res://ea-nasir.jpeg"}}}
var unlocked_items = {}
var health = 100
var gold = 0
var enemy_texture
var enemy_rewards = 0
#var enemies = [{"name": "Big John", "date": "1444", "difficulty": "Hard", "rewards": "1 Gold", "actions": {"selected_items": {"Golden Axe": {"action": {"type": "attack","value": 14,"mods": ["freeze"], "name": "Golden chop", "crit_chance": 0}, "passive": {"name": "Golden Glimmer", "defence": 4, "damage": 0, "passive_status": "john"}, "tooltip": "tooltip", "texture": "res://ea-nasir.jpeg"}}}, "texture": "res://ea-nasir.jpeg", "ce":"AD"}]



var enemies = [
	{
  "name": "Otto Von Bismarck",
  "date": "1815",
  "difficulty": "Easy",
  "rewards": 2,
  "actions": {
	"selected_items": {
	  "Pickelhelm": {
		"action": {
		  "type": "head",
		  "value": 1,
		  "mods": ["undermine", "ignoreDefence"],
		  "name": "Iron and Blood",
		  "crit_chance": 5
		},
		"passive": {
		  "name": "Prussian Headgear",
		  "defence": 1,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sturdy Pickelhelm worn by Bismarck.",
		"texture": "res://pickelhelm.jpeg"
	  },
	  "Iron Cuirass": {
		"action": {
		  "type": "body",
		  "value": 0,
		  "mods": ["weaken"],
		  "name": "Art Of The Next Best",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Prussian Fortitude",
		  "defence": 2,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sturdy Prussian cuirass worn by Bismarck.",
		"texture": "res://prussian-cuirass.jpeg"
	  },
	  "Steel Saber": {
		"action": {
		  "type": "hand",
		  "value": 4,
		  "mods": [],
		  "name": "Sword of Authority",
		  "crit_chance": 15
		},
		"passive": {
		  "name": "Blade of Power",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sharp and imposing steel saber.",
		"texture": "res://steel-saber.jpeg"
	  },
	  "Sturdy Cane": {
		"action": {
		  "type": "hand",
		  "value": 3,
		  "mods": [],
		  "name": "Great Presence",
		  "crit_chance": 50
		},
		"passive": {
		  "name": "Unyielding Grip",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sturdy cane used by Bismarck.",
		"texture": "res://sturdy-cane.jpeg"
	  }
	}
  },
  "texture": "res://pickelhelm.jpeg",
  "ce": "AD"
},
{
  "name": "Genghis Khan",
  "date": "1162",
  "difficulty": "Hard",
  "rewards": 4,
  "actions": {
	"selected_items": {
	  "Mongol Bow": {
		"action": {
		  "type": "hand",
		  "value": 8,
		  "mods": ["bleed"],
		  "name": "Khan's Precision Shot",
		  "crit_chance": 20
		},
		"passive": {
		  "name": "Nomadic Archer",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A powerful Mongol bow used by Genghis Khan.",
		"texture": "res://mongol-bow.jpeg"
	  },
	  "Mongol Saber": {
		"action": {
		  "type": "hand",
		  "value": 7,
		  "mods": [],
		  "name": "Saber of the Steppes",
		  "crit_chance": 10
		},
		"passive": {
		  "name": "Rider's Blade",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sharp Mongol saber wielded by Genghis Khan.",
		"texture": "res://mongol-saber.jpeg"
	  },
	  "Mongol Horse": {
		"action": {
		  "type": "body",
		  "value": 3,
		  "mods": ["evade"],
		  "name": "Swift Ride",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Nomadic Companion",
		  "defence": 3,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A sturdy Mongol horse ridden by Genghis Khan.",
		"texture": "res://mongol-horse.jpeg"
	  },
	  "Warrior Helm": {
		"action": {
		  "type": "head",
		  "value": 0,
		  "mods": ["weaken"],
		  "name": "Helm of the Khan",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Warrior's Guard",
		  "defence": 1,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A warrior's helmet worn by Genghis Khan.",
		"texture": "res://warrior-helm.jpeg"
	  }
	}
  },
  "texture": "res://genghis-khan.jpeg",
  "ce": "AD"
},
{
  "name": "Julius Caesar",
  "date": "0100",
  "difficulty": "Medium",
  "rewards": 2,
  "actions": {
	"selected_items": {
	  "Imperial Gladius": {
		"action": {
		  "type": "hand",
		  "value": 7,
		  "mods": ["intimidate"],
		  "name": "Imperial Strike",
		  "crit_chance": 15
		},
		"passive": {
		  "name": "Imperator's Blade",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "An imperial gladius wielded by Julius Caesar.",
		"texture": "res://imperial-gladius.jpeg"
	  },
	  "Roman Armor": {
		"action": {
		  "type": "body",
		  "value": 0,
		  "mods": ["weaken"],
		  "name": "Legionary Resilience",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Roman Defender",
		  "defence": 5,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "Traditional Roman armor worn by Caesar.",
		"texture": "res://roman-armor.jpeg"
	  },
	  "Laurel Crown": {
		"action": {
		  "type": "head",
		  "value": 0,
		  "mods": ["intimidate"],
		  "name": "Crown of Triumph",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Triumphant Leader",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A laurel crown worn by the triumphant Caesar.",
		"texture": "res://laurel-crown.jpeg"
	  },
	  "Roman Standard": {
		"action": {
		  "type": "hand",
		  "value": 3,
		  "mods": [],
		  "name": "Eagle Standard",
		  "crit_chance": 10
		},
		"passive": {
		  "name": "Legionary Symbol",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": "Imperio-Praesentia"
		},
		"tooltip": "The Roman Eagle Standard carried by Caesar's legions.",
		"texture": "res://eagle-standard.jpeg"
	  }
	}
  },
  "texture": "res://julius-caesar.jpeg",
  "ce": "BC"
},
{
  "name": "Ea Nasir",
  "date": "1750",
  "difficulty": "Impossible",
  "rewards": 6,
  "actions": {
	"selected_items": {
	  "Clay Complaint Tablet": {
		"action": {
		  "type": "hand",
		  "value": 8,
		  "mods": [],
		  "name": "Ignored Complaint Tablet Throw",
		  "crit_chance": 15
		},
		"passive": {
		  "name": "Unfazed",
		  "defence": 1,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A complaint tablet Ea Nasir promptly ignored.",
		"texture": "res://tablet.jpeg"
	  },
	  "River Boat": {
		"action": {
		  "type": "body",
		  "value": 1,
		  "mods": ["undermine"],
		  "name": "Transport Copper",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Copper Mogul",
		  "defence": 5,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "Mesopotamian river boat.",
		"texture": "res://river-boat.jpeg"
	  },
	  "Cool Beard": {
		"action": {
		  "type": "head",
		  "value": 0,
		  "mods": ["intimidate", "weaken"],
		  "name": "Overwhelmingly Unbothered",
		  "crit_chance": 0
		},
		"passive": {
		  "name": "Great Salesman",
		  "defence": 0,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A cool beard style that was popular at the time.",
		"texture": "res://beard.jpeg"
	  },
	  "Bag of Shekels": {
		"action": {
		  "type": "hand",
		  "value": 6,
		  "mods": [],
		  "name": "Money Slap",
		  "crit_chance": 30
		},
		"passive": {
		  "name": "Loaded",
		  "defence": 1,
		  "damage": 0,
		  "passive_status": ""
		},
		"tooltip": "A bag of Babylonian money.",
		"texture": "res://bag_shekels.jpeg"
	  }
	}
  },
  "texture": "res://ea-nasir.jpeg",
  "ce": "BC"
}

]








# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
