class_name Player extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSIVITY = 0.4
const LOOK_SENSIVITY = 2.5

var mouse_locked: bool = false;
var is_debug: bool
var is_mobile: bool
var is_pc: bool
var died: bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var camera: Camera3D

@onready var all_interactions = []
@onready var interact_label = $"Control/Interaction label"
@onready var head = $Head

signal died_signal

func _ready():
	assert(camera)
	
	is_debug = OS.has_feature("debug")
	is_mobile = OS.has_feature("mobile")
	is_pc = OS.has_feature("pc")
	
	if is_pc:
		_lock_mouse(true)
	
	update_interactions()
	
func _input(event):
	if died:
		return
		
	if event is InputEventMouseMotion && mouse_locked:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSIVITY))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSIVITY))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if died:
		return
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var look_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	rotate_y(deg_to_rad(-look_dir.x * LOOK_SENSIVITY))
	head.rotate_x(deg_to_rad(-look_dir.y * LOOK_SENSIVITY))
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

	move_and_slide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if died:
		return
		
	if is_pc and Input.is_action_just_pressed("toggle_mouse"):
		_lock_mouse(not mouse_locked)
		
	if Input.is_action_just_pressed("use"):
		if all_interactions:
			all_interactions[0].Use()


func _lock_mouse(should_lock: bool):
	if should_lock:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_locked = should_lock


#region Interaction

func _on_interaction_area_area_entered(area):
	if died:
		return
		
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

#endregion

func _on_damage_area_damaged(_damage_amount, _current_health):
	var hit_tween = get_tree().create_tween()
	hit_tween.tween_property(camera, "rotation:z", deg_to_rad(10), 0.1)
	hit_tween.tween_property(camera, "rotation:z", deg_to_rad(0), 0.1)
	await hit_tween.finished

func _on_damage_area_die():
	died = true
	all_interactions.clear()
	update_interactions()
	
	died_signal.emit()
	
	var die_tween = get_tree().create_tween()
	die_tween.tween_property(camera, "rotation:z", deg_to_rad(10), 1)
	die_tween.parallel().tween_property(camera, "position", Vector3(0,-1.5,0), 1)
	await die_tween.finished


