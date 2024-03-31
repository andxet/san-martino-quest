extends Node

const SETTINGS_FILE_PATH = "user://settings.cfg"
const SECTION_NAME = "Settings"

enum languages { en_en, it_it }

class Settings:
	var mouse_sensitivity = 0.0
	var joystick_sensitivity = 0.0
	var fullscreen = true
	var language = languages.en_en

var settings: Settings

func _init():	
	load_config_file()
	apply()

func load_config_file():
	var _configFile = ConfigFile.new()	
	var err = _configFile.load(SETTINGS_FILE_PATH)
	
	if err == OK:
		var settings_dict = _configFile.get_value(SECTION_NAME, SECTION_NAME)
		if load(settings_dict["@path"]):
			settings = dict_to_inst(settings_dict)
		else:
			restore_to_default()
			save_config_file()
	else:
		restore_to_default()
	
func save_config_file():
	var temp_dict = inst_to_dict(settings)
	
	var _configFile = ConfigFile.new()
	_configFile.set_value(SECTION_NAME, SECTION_NAME, temp_dict)
	
	_configFile.save(SETTINGS_FILE_PATH)

func restore_to_default():
		settings = Settings.new()
	
func apply():
	if(settings.fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	TranslationServer.set_locale(languages.find_key(settings.language))

