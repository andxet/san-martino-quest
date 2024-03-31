class_name PauseMenu extends Control

@onready var continue_button = $VBoxContainer/ContinueButton
@onready var to_main_menu_button = $VBoxContainer/ToMainMenuButton
@onready var exit_button = $VBoxContainer/ExitButton

var paused: bool = false
var scene_manager: SceneManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	
	scene_manager = get_node("/root/SceneManager")	
	
	var load_main_menu = func(): 
		get_tree().paused = false
		scene_manager.load_main_menu()
	var exit = func(): get_tree().quit()
	
	continue_button.pressed.connect(switch_pause)
	to_main_menu_button.pressed.connect(load_main_menu)
	exit_button.pressed.connect(exit)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	if Input.is_action_just_pressed("pause"):
		switch_pause()

func switch_pause():		
	paused = not paused
	get_tree().paused = paused	
	
	if paused:	
		show() 
		if OS.has_feature("pc"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		continue_button.grab_focus()
	else:	
		hide()
		if OS.has_feature("pc"):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

