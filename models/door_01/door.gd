extends Node3D

@onready var animation_player = $AnimationPlayer

@export var start_closed : bool = true
var is_open : bool

signal on_closed
signal on_opened

# Called when the node enters the scene tree for the first time.
func _ready():
	if(start_closed):
		animation_player.seek(0)
	else:
		animation_player.seek(animation_player.current_animation_length)
	is_open = !start_closed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open():
	animation_player.speed_scale = 1
	animation_player.play()
	
func close():
	animation_player.speed_scale = -1
	animation_player.play()


func _on_interaction_area_on_used():
	if(is_open):
		close()
	else:
		open()
