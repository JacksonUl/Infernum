extends Node2D



# Press escape to quit the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		
	


func _on_player_character_death():
	get_tree().change_scene_to_file("res://Scenes/Prototype Scenes/Start.tscn")
