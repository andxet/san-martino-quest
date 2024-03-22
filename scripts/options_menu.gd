class_name OptionsMenu extends Panel

@onready var language_button = $GridContainer/LanguageButton
@onready var mouse_sens_slider = $GridContainer/MouseSensSlider
@onready var joystick_sens_slider = $GridContainer/JoystickSensSlider
@onready var is_full_screen = $GridContainer/IsFullScreen

var settings_manager: GameSettingsManager
var settings: GameSettingsManager.Settings

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_manager = get_node("/root/GameSettingsManager")
	settings_manager.LoadConfigFile()
	settings = settings_manager.settings
	
	for lang in GameSettingsManager.languages:
		language_button.add_item(tr(lang))
	
	UpdateControls()

func Save():
	settings_manager.SaveConfigFile()
	
func RestoreToDefault():
	settings_manager.RestoreToDefault()
	settings_manager.SaveConfigFile()
	UpdateControls()
	
func UpdateControls():
	language_button.select(settings.language)
	mouse_sens_slider.set_value_no_signal(settings.mouse_sensitivity)
	joystick_sens_slider.set_value_no_signal(settings.joystick_sensitivity)
	is_full_screen.set_pressed_no_signal(settings.fullscreen)

func SaveControlsValues():
	settings.language = language_button.selected
	settings.mouse_sensitivity = mouse_sens_slider.value
	settings.joystick_sensitivity = joystick_sens_slider.value
	settings.fullscreen = is_full_screen.button_pressed
	
func Apply():
	settings_manager.Apply()
	
func ApplySettings():
	SaveControlsValues()
	Save()
	Apply()
