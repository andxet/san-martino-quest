class_name MainMenu extends Control

@export var main_menu: MainMenuUI
@export var options_menu = OptionsMenuUI

func _ready():
	if OS.has_feature("pc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	assert(main_menu)
	assert(options_menu)
	main_menu.options_pressed.connect(GoToOptions)
	options_menu.back_pressed.connect(GoToMainMenu)

func GoToOptions():	
	main_menu.visible = false
	options_menu.visible = true
	
func GoToMainMenu():
	main_menu.visible = true
	options_menu.visible = false
