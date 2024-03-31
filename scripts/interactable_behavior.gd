class_name InteractableBehavior extends Area3D

@export var interact_label : String = "Use"

signal on_used

var interaction_label_decorator: Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func Use():
	on_used.emit()

func get_interaction_label() -> String:
	if interaction_label_decorator.is_null():
		return interact_label
	else:
		return interaction_label_decorator.call(interact_label)
	
