class_name FreeQuest extends Quest

@export var quest_label: Label
@export var idol: PickupableIdol
@export var door_side: Door
@export var door_front: Door
@export var front_door_lever: Lever
@export var side_door_lever: Lever
@export var traps: Trap
@export var fade_out: ColorRect

static func get_type():
	return 1
	
func _prepare():
	assert(idol)
	assert(door_side)
	assert(door_front)
	assert(front_door_lever)
	assert(side_door_lever)
	assert(traps)
	assert(fade_out)
	assert(quest_label)
	
	idol.hide()
	quest_label.hide()
	traps.hide()
	door_side.locked = false
	front_door_lever.hide()
	side_door_lever.hide()
	door_front.locked = false
	fade_out.hide()
	
func _run():
	pass
	# End quest

