class_name OptionsMenuUI extends Panel

@onready var language_button = $GridContainer/LanguageButton
@onready var mouse_sens_slider = $GridContainer/MouseSensSlider
@onready var joystick_sens_slider = $GridContainer/JoystickSensSlider
@onready var is_full_screen = $GridContainer/IsFullScreen
@onready var back_button = $BackButton
@onready var apply_button = $HBoxContainer/ApplyButton
@onready var reset_button = $HBoxContainer/ResetButton

signal on_back_pressed

var settings_manager: GameSettingsManager
var settings: GameSettingsManager.Settings

# Called when the node enters the scene tree for the first time.
func _ready():
	settings_manager = get_node("/root/GameSettingsManager")
	settings_manager.load_config_file()
	settings = settings_manager.settings
	
	for lang in GameSettingsManager.languages:
		language_button.add_item(tr(lang))
	
	apply_button.pressed.connect(_on_apply_pressed)
	back_button.pressed.connect(_on_back_pressed)
	reset_button.pressed.connect(restore_to_default)
	
	update_controls()

func set_focus():	
	back_button.grab_focus()

func save():
	settings_manager.save_config_file()
	
func restore_to_default():
	settings_manager.restore_to_default()
	settings = settings_manager.settings
	update_controls()
	
func update_controls():
	language_button.select(settings.language)
	mouse_sens_slider.set_value_no_signal(settings.mouse_sensitivity)
	joystick_sens_slider.set_value_no_signal(settings.joystick_sensitivity)
	is_full_screen.set_pressed_no_signal(settings.fullscreen)

func save_controls_value():
	settings.language = language_button.selected
	settings.mouse_sensitivity = mouse_sens_slider.value
	settings.joystick_sensitivity = joystick_sens_slider.value
	settings.fullscreen = is_full_screen.button_pressed
	
func apply():
	settings_manager.apply()
	update_language_button_labels()
	
	
func update_language_button_labels():
	for i in range(language_button.item_count):
		language_button.remove_item(0)
	for lang in GameSettingsManager.languages:
		language_button.add_item(tr(lang))
	language_button.select(settings.language)

func _on_apply_pressed():
	save_controls_value()
	save()
	apply()
	
func _on_back_pressed():
	on_back_pressed.emit()
