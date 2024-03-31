class_name SanMartinoQuest extends Quest

@export var trap_path_completion_seconds: float = 20

@export var quest_label: Label
@export var idol: PickupableIdol
@export var door_side: Door
@export var door_front: Door
@export var front_door_lever: Lever
@export var side_door_lever: Lever
@export var traps = Trap
@export var close_door_area: Area3D
@export var path_follow_3d: PathFollow3D
@export var win_area: Area3D
@export var fade_out: ColorRect
@export var player: Player

static func get_type():
	return 0

func _prepare():
	assert(idol)
	assert(door_side)
	assert(door_front)
	assert(front_door_lever)
	assert(side_door_lever)
	assert(traps)
	assert(close_door_area)
	assert(path_follow_3d)
	assert(win_area)
	assert(fade_out)
	assert(player)
	
	assert(quest_label)
	
	quest_label.text = ""
	traps.visible = false
	door_side.locked = true
	front_door_lever.on_pull.connect(_on_front_door_lever_on_pull)
	side_door_lever.on_pull.connect(_on_side_door_lever_on_pull)
	door_front.locked = true
	fade_out.hide()
	fade_out.color = Color(Color.BLACK, 0)
	player.died_signal.connect(_on_player_died_signal)
	
func _run():
	quest_label.text = "Find the idol and run!"
	await get_tree().create_timer(5).timeout
	
	quest_label.text = "Find a way to get in"
	await front_door_lever.on_pull_down
	
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

#region Signals callbacks
func _on_player_died_signal():
	await get_tree().create_timer(5).timeout
	goto_main_menu()
	
func _on_front_door_lever_on_pull():
	door_front.locked = false
	door_front.open()
	
func _on_side_door_lever_on_pull():
	door_side.locked = false
	door_side.open()
#endregion
