class_name DamageOnTouch extends Area3D

@export var damage: int
@export var cooldown: float = 1.0

var damaging_bodies: Array[Area3D] = []
var cooldown_damaged = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for body in damaging_bodies:
		if body not in cooldown_damaged:
			body.damage(damage)
			do_cooldown(body)

func do_cooldown(body: Area3D):
	cooldown_damaged[body] = null
	await get_tree().create_timer(cooldown).timeout
	cooldown_damaged.erase(body)


func _on_area_entered(area: Area3D):
	if area.has_method("damage"):
		damaging_bodies.append(area)


func _on_area_exited(area: Area3D):
	if area.has_method("damage"):
		damaging_bodies.erase(area)
