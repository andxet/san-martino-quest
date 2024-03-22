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
	LoadConfigFile()
	Apply()

func LoadConfigFile():
	var _configFile = ConfigFile.new()	
	var err = _configFile.load(SETTINGS_FILE_PATH)
	
	if err == OK:
		var settings_dict = _configFile.get_value(SECTION_NAME, SECTION_NAME)
		settings = dict_to_inst(settings_dict)
	else:
		RestoreToDefault()
	
func SaveConfigFile():
	var temp_dict = inst_to_dict(settings)
	
	var _configFile = ConfigFile.new()
	_configFile.set_value(SECTION_NAME, SECTION_NAME, temp_dict)
	
	_configFile.save(SETTINGS_FILE_PATH)

func RestoreToDefault():
		settings = Settings.new()
	
func Apply():
	if(settings.fullscreen):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	TranslationServer.set_locale(languages.find_key(settings.language))

