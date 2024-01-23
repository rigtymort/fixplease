extends Node2D


@onready var pause_menu = $"."

func pause():
	get_tree().paused = true
	pause_menu.show()
	
func  unpause():
	get_tree().paused = false
	pause_menu.hide()

