extends Node2D



# Press escape to quit the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
