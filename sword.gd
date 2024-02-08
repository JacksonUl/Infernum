extends Node2D


	

func _on_player_character_attack():
	$AnimationPlayer.play("Swing")
