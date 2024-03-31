class_name MainMenuUI extends Panel

signal options_pressed

@onready var start_game = $VBoxContainer/StartGame
@onready var free_mode = $VBoxContainer/FreeMode
@onready var options = $VBoxContainer/Options
@onready var exit = $VBoxContainer/Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game.pressed.connect(_on_start_game_pressed)
	free_mode.pressed.connect(_on_free_mode_pressed)
	options.pressed.connect(_on_options_pressed)
	exit.pressed.connect(_on_exit_pressed)
	
func set_focus():	
	start_game.grab_focus()

func _on_exit_pressed():
	get_tree().quit()
	
func _on_options_pressed():
	options_pressed.emit()

func _on_start_game_pressed():
	SceneManager.load_game_quest()
	
func _on_free_mode_pressed():
	SceneManager.load_game_free()
