class_name VirtualButton

extends Control

enum Visibility_mode {
	ALWAYS, ## Always visible
	TOUCHSCREEN_ONLY ## Visible on touch screens only
}

## If the button is always visible, or is shown only if there is a touchscreen
@export var visibility_mode := Visibility_mode.ALWAYS

## If true, the joystick uses Input Actions (Project -> Project Settings -> Input Map)
@export var use_input_actions := true

@export var action := "action"

# PUBLIC VARIABLES

## If the joystick is receiving inputs.
var is_pressed := false

# The joystick output.
var output := false

# FUNCTIONS

func _ready() -> void:
	if not DisplayServer.is_touchscreen_available() and visibility_mode == Visibility_mode.TOUCHSCREEN_ONLY:
		hide()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			_update_input_action(true)
			get_viewport().set_input_as_handled()
		else:
			_reset()
			get_viewport().set_input_as_handled()

func _update_input_action(value: bool):
	if value:
		Input.action_press(action)
	else:
		Input.action_release(action)

func _reset():
	is_pressed = false
	output = false
	if use_input_actions:
		if Input.is_action_pressed(action) or Input.is_action_just_pressed(action):
			Input.action_release(action)
