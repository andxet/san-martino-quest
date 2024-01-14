extends CharacterBody3D

@onready var head = $Head

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSIVITY = 0.4

var mouse_locked: bool = false;
var is_debug: bool
var is_mobile: bool
var is_pc: bool

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	is_debug = OS.has_feature("debug")
	is_mobile = OS.has_feature("mobile")
	is_pc = OS.has_feature("pc")
	
	if is_pc:
		_lock_mouse(true)
	
func _input(event):
	if event is InputEventMouseMotion && mouse_locked:
		rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENSIVITY))
		head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENSIVITY))
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

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

	move_and_slide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_pc and Input.is_action_just_pressed("toggle_mouse"):
		_lock_mouse(not mouse_locked)


func _lock_mouse(should_lock: bool):
	if should_lock:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_locked = should_lock
