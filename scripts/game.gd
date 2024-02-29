extends Node3D

@export var trap_path_completion_seconds: float = 20

@onready var virtual_joysticks = $UI/VirtualJoysticks

@onready var idol = $PickupableIdol
@onready var door_side = $door_side
@onready var door_front = $door_front
@onready var lever = $"front door lever"
@onready var traps = $"Traps path/PathFollow3D/Traps"
@onready var close_door_area = $"Close door area"
@onready var path_follow_3d = $"Traps path/PathFollow3D"
@onready var win_area = $"Win area"
@onready var fade_out = $UI/FadeOut

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
	assert(path_follow_3d)
	
	quest_label.text = ""
	traps.visible = false
	fade_out.hide()
	fade_out.color = Color(Color.BLACK, 0)
	quest()

func quest():
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
	
	door_trap()
	start_traps_movement()
	
	quest_label.text = "The idol is vanishing! Get back!"
	
	await idol.on_end_pick_animation	
	
	quest_label.text = "It's a trap! Get out! Get out!"	
	
	await win_area.area_entered
	
	quest_label.text = "You escaped the ruins!"	
	await get_tree().create_timer(3).timeout
	quest_label.text = "The golden idol was cursed, a trap almost killed you."	
	await get_tree().create_timer(3).timeout
	quest_label.text = "This time you'll have to give up"	
	await get_tree().create_timer(3).timeout
	quest_label.text = "Sooner or later you'll catch the idol!"	
	
	await get_tree().create_timer(5).timeout
	
	await fade_out_anim()
	
	get_tree().change_scene_to_file("res://scenes/main menu.tscn")
	
	goto_main_menu()
	# End quest

func door_trap():
	await close_door_area.area_entered
	door_front.close()
	door_front.locked = true

func start_traps_movement():
	traps.visible = true
	var trap_tween = get_tree().create_tween()
	trap_tween.tween_property(path_follow_3d, "progress_ratio", 1, trap_path_completion_seconds)
	await trap_tween.finished

func fade_out_anim():
	fade_out.visible = true
	var fade_out_tween = get_tree().create_tween()
	fade_out_tween.tween_property(fade_out, "color", Color(Color.BLACK, 1.0), 4)
	await fade_out_tween.finished

func goto_main_menu():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


#region Signals
func _on_player_died_signal():
	await get_tree().create_timer(5).timeout
	goto_main_menu()
	
func _on_side_door_lever_on_pull():
	door_side.locked = false
	door_side.open()
#endregion
