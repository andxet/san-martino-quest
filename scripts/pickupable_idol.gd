extends Node3D
class_name PickupableIdol

@export var light: Light3D
@export var tween_root: Node3D
@export var pickup_node: Pickup

signal on_picked_up
signal on_end_pick_animation

var rotation_tween: Tween
var moving_tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	pickup_node.callback = pickup_visual	
	
	rotation_tween = get_tree().create_tween()
	rotation_tween.set_loops()
	rotation_tween.tween_property(tween_root, "rotation:y", deg_to_rad(360), 4).as_relative()
	
	moving_tween = get_tree().create_tween()
	moving_tween.set_loops()
	moving_tween.tween_property(tween_root, "position:y", -0.5, 1).as_relative().set_trans(Tween.TRANS_SINE)
	moving_tween.tween_property(tween_root, "position:y", 0.5, 1).as_relative().set_trans(Tween.TRANS_SINE)
	

func pickup_visual():
	moving_tween.kill()
	
	on_picked_up.emit()
	
	if light:
		var light_tween = get_tree().create_tween()
		light_tween.tween_property(light, "light_energy", 15, 3)
		await light_tween.finished
		print("finished")
	rotation_tween.kill()
	
	if tween_root:
		var size_tween = get_tree().create_tween()
		size_tween.tween_property(tween_root, "scale", Vector3(0,5,0), 1)
		
		rotation_tween = get_tree().create_tween()
		rotation_tween.set_loops()
		rotation_tween.tween_property(tween_root, "rotation:y", deg_to_rad(360), 0.3).as_relative()
		
		await size_tween.finished
		
	on_end_pick_animation.emit()
