class_name Door extends Node3D


@onready var animation_player = $AnimationPlayer
@onready var interaction_area = $"Hinge/Interaction area"

@export var locked: bool = true

var is_open : bool = false

signal on_closed
signal on_opened
signal on_locked

# Called when the node enters the scene tree for the first time.
func _ready():
	if locked:
		animation_player.play("door/RESET")
	interaction_area.interaction_label_decorator = decorate_interaction_prompt


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func open():
	if locked:
		on_locked.emit()
		return
	$AnimationPlayer.play("door/open")
	is_open = true
	
func close():
	$AnimationPlayer.play_backwards("door/open")
	is_open = false


func _on_interaction_area_on_used():
	print("Action used!! %s", is_open)
	if(is_open):
		close()
	else:
		open()

func decorate_interaction_prompt(int_prompt: String):
	if(locked):
		return "(" + tr("locked") + ")"
	else:
		return int_prompt
