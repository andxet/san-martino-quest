extends Node3D

@export var enable_on_debug: Array[Node]
@export var disable_on_debug: Array[Node]
@export var enable_on_release: Array[Node]
@export var disable_on_release: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.has_feature("mobile"):
		print("Is mobile!")
	elif OS.has_feature("pc"):
		print("Is a pc!")
		
	if OS.has_feature("debug"):
		print("Debug build")
	elif OS.has_feature("release"):
		print("Release build")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass