extends Node3D

@export var light: Light3D
@export var tween_root: Node3D
@export var pickup_node: Pickup

signal on_picked_up
signal on_end_pick_animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pickup_node.callback = pickup_visual

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pickup_visual():
	on_picked_up.emit()
	
	if light:
		var light_tween = get_tree().create_tween()
		light_tween.tween_property(light, "light_energy", 15, 3)
		await light_tween.finished
	
	if tween_root:
		var size_tween = get_tree().create_tween()
		size_tween.tween_property(tween_root, "scale", Vector3(0,5,0), 1)
		await size_tween.finished
		
	on_end_pick_animation.emit()
