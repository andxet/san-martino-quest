class_name MainMenuUI extends Control

signal options_pressed

@onready var start_game = $VBoxContainer/StartGame
@onready var options = $VBoxContainer/Options
@onready var exit = $VBoxContainer/Exit

var scene_manager: SceneManager

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game.pressed.connect(_on_start_game_pressed)
	options.pressed.connect(_on_options_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
	scene_manager = get_node("/root/SceneManager")
	
func set_focus():	
	start_game.grab_focus()

func _on_exit_pressed():
	get_tree().quit()
	
func _on_options_pressed():
	options_pressed.emit()

func _on_start_game_pressed():
	scene_manager.load_game()
