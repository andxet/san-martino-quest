extends Control

@onready var main_menu = $"Main Menu"
@onready var options_menu = $OptionsMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	GoToMainMenu()

func GoToOptions():	
	main_menu.visible = false
	options_menu.visible = true
	
func GoToMainMenu():
	main_menu.visible = true
	options_menu.visible = false
	
