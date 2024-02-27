extends Node3D

@onready var virtual_joysticks = $UI/VirtualJoysticks

@onready var idol = $PickupableIdol
@onready var door_side = $door_side
@onready var door_front = $door_front
@onready var lever = $"front door lever"
@onready var traps = $Traps
@onready var close_door_area = $"Close door area"

@export var quest_label: Label

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
	assert(virtual_joysticks)
	assert(idol)
	assert(door_side)
	assert(door_front)
	assert(lever)
	assert(traps)
	assert(close_door_area)
	assert(quest_label)
	
	quest_label.text = ""
	quest()

func quest():	
	print("Starting game!")
	quest_label.text = "Find the idol and run!"
	await get_tree().create_timer(5).timeout
	
	quest_label.text = "Find a way to get in"
	await lever.on_pull_down
	door_front.locked = false
	door_front.open()
	
	quest_label.text = "The front door is open!"
	await get_tree().create_timer(5).timeout
	
	quest_label.text = "Get in and take the idol!"
	await idol.on_picked_up
	quest_label.text = "The idol is vanishing! Get back!"
	
	await idol.on_end_pick_animation
	quest_label.text = "It's a trap! Get out! Get out!"
	
	#activate traps
		
	await close_door_area.area_entered
	door_front.close()
	door_front.locked = true
	
	# End quest

func _on_side_door_lever_on_pull():
	door_side.locked = false
	door_side.open()
