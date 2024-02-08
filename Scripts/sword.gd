extends Node2D


func _input(event):
	if event.is_action_pressed("Move_Right"):
		$Sprite2D.flip_h = false
	if event.is_action_pressed("Move_Left"):
		$Sprite2D.flip_h = true
	

func _on_player_character_attack():
	$AnimationPlayer.play("Swing")
