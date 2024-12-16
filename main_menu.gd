class_name MainMenu
extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button as Button
@onready var options_menu = $Options_Menu as OptionsMenu
@onready var margin_container = $MarginContainer as MarginContainer
@onready var start_level = preload("res://main.tscn") as PackedScene

func _ready():
	print("Start Button: ", start_button)
	print("Options Button: ", options_button)
	print("Exit Button: ", exit_button)
	print("Options Menu: ", options_menu)
	handle_connecting_signals()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_options_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.set_process(false)
	options_menu.visible = false

func handle_connecting_signals() -> void:
	if start_button:
		start_button.button_down.connect(on_start_pressed)
	if options_button:
		options_button.button_down.connect(on_options_pressed)
	if exit_button:
		exit_button.button_down.connect(on_exit_pressed)
	if options_menu:
		options_menu.exit_options_menu.connect(on_exit_options_menu)
