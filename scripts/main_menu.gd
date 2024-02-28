extends Node3D

func _ready():
	if OS.has_feature("pc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_exit_pressed():
	get_tree().quit()

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")
