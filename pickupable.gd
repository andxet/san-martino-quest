class_name Pickup extends Node3D

class PickupItem:
	var name: String = "PickupItem"
	
	func _init():
		pass

@export var pickup_name: String = "Pickup name"
@export var delete_root: bool = true
@export var root_to_delete: Node3D

var callback: Callable

var pickup_item = PickupItem.new()
var picked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pickup_item.name = pickup_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pickup() -> PickupItem:
	if picked:
		return
	picked = true
	destroy()
	return pickup_item
	
func destroy():
	if callback:
		await callback.call()
		
	if delete_root:
		root_to_delete.queue_free()


func _on_interaction_area_on_used():
	pickup()
