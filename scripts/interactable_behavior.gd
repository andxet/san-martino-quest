class_name InteractableBehavior extends Area3D

@export var interact_label : String = "Use"

signal on_used

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func Use():
	on_used.emit()
