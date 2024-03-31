class_name PauseMenu extends Control

@export var main_menu_scene: PackedScene

@onready var continue_button = $VBoxContainer/ContinueButton
@onready var to_main_menu_button = $VBoxContainer/ToMainMenuButton
@onready var exit_button = $VBoxContainer/ExitButton

var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	var load_main_menu = func(): get_tree().change_scene_to_packed(main_menu_scene)
	var exit = func(): get_tree().quit()
	
	continue_button.pressed.connect(switch_pause)
	to_main_menu_button.pressed.connect(load_main_menu)
	exit_button.pressed.connect(exit)
	
	continue_button.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		switch_pause()

func switch_pause():		
	paused = not paused
	
	get_tree().paused = paused	
	show() if paused else hide()
	
	if OS.has_feature("pc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) if paused else Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

