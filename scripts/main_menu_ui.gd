class_name MainMenuUI extends Control

@export var start_game_scene: PackedScene

signal options_pressed

@onready var start_game = $VBoxContainer/StartGame
@onready var options = $VBoxContainer/Options
@onready var exit = $VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(start_game_scene)
	start_game.pressed.connect(_on_start_game_pressed)
	options.pressed.connect(_on_options_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func set_focus():	
	start_game.grab_focus()

func _on_exit_pressed():
	get_tree().quit()
	
func _on_options_pressed():
	options_pressed.emit()

func _on_start_game_pressed():
	get_tree().change_scene_to_packed(start_game_scene)
