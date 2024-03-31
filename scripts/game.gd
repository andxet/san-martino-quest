class_name Game extends Node3D

@onready var virtual_joysticks = $UI/VirtualJoysticks

@export var quests: Array[Quest]

var current_quest: Quest

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("mobile"):
		print("Is mobile!")
		virtual_joysticks.visible = true
		
	elif OS.has_feature("pc"):
		print("Is a pc!")
		virtual_joysticks.visible = false
		
	if OS.has_feature("debug"):
		print("Debug build")
	elif OS.has_feature("release"):
		print("Release build")
	
	for quest in quests:
		if quest.get_type() == SceneManager.quest_to_load:
			quest._prepare()
			quest._run()
	
