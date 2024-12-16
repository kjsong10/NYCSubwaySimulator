class_name MainGame
extends Node3D

@export var pause_menu_packed_scene : PackedScene = null
@onready var ui_container = $UI_Container as CanvasLayer

func _unhandled_key_input(event) -> void:
	if event.is_action("pause"):
		var new_pause_menu : Pause_Menu = pause_menu_packed_scene.instantiate()
		
		ui_container.add_child(new_pause_menu)
