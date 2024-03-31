extends Node

const MAIN_MENU = preload("res://scenes/main_menu.tscn")
const GAME = preload("res://scenes/game.tscn")

var quest_to_load

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("load_main_menu")

func load_main_menu():
	get_tree().change_scene_to_packed(MAIN_MENU)
	
func load_game_quest():
	quest_to_load = SanMartinoQuest.get_type()
	get_tree().change_scene_to_packed(GAME)
	
func load_game_free():
	quest_to_load = FreeQuest.get_type()
	get_tree().change_scene_to_packed(GAME)
