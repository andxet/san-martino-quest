class_name Health extends Node3D

@export var max_health: int
@export var health_bar: ProgressBar
@export var die_ui: Control

var died: bool: 
	get: return current_health <=0 

var current_health: int

signal damaged(damage_amount: int, current_health: int)
signal die

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(max_health > 0)
	assert(health_bar)
	assert(die_ui)
	die_ui.visible = false
	current_health = max_health
	update_health_bar()

func damage(amount: int) -> void:
	if died:
		return
	
	current_health -= amount
	
	update_health_bar()
	
	damaged.emit(amount, current_health)
	if died:
		die.emit()
		die_ui.visible = true
		
func update_health_bar():
	health_bar.value = current_health as float / max_health
