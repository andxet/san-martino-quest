extends Node3D
class_name Lever

signal on_pull
signal on_pull_down
signal on_pull_up

var is_up: bool = true
@export var consent_only_one_pull: bool = false
var was_pulled: bool = false

@onready var animator = $"AnimationPlayer"

func pull_down():
	if not is_up:
		return
	is_up = false
	
	animator.play("pull")
	on_pull.emit()
	on_pull_down.emit()
	
func pull_up():
	if is_up:
		return
	is_up = true
	
	animator.play_backwards("pull")
	on_pull.emit()
	on_pull_up.emit()

func pull():
	if consent_only_one_pull and was_pulled:
		return
	was_pulled = true
	
	if is_up:
		pull_down()
	else:
		pull_up()


func _on_interaction_area_on_used():
	pull()
