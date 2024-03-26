class_name MainMenu extends Node3D

@export var main_menu: MainMenuUI
@export var options_menu: OptionsMenuUI

func _ready():
	if OS.has_feature("pc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	assert(main_menu)
	assert(options_menu)
	main_menu.options_pressed.connect(go_to_options)
	options_menu.on_back_pressed.connect(go_to_main_menu)
	go_to_main_menu()

func go_to_options():
	main_menu.visible = false
	options_menu.visible = true
	options_menu.set_focus()
	
func go_to_main_menu():
	main_menu.visible = true
	options_menu.visible = false
	main_menu.set_focus()
