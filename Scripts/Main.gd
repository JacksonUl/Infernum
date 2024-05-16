extends Node2D

signal mobPath
signal enemyDamage(enemytype)
signal enemykilled


var score = 0

var mob_scene = preload("res://Scenes/Enemy.tscn").instantiate()
var othermob = preload("res://Scenes/enemy2.tscn").instantiate()

func _ready():
	mob_scene.add_to_group("Enemys")
	othermob.add_to_group("Enemys")
	mob_scene.position = Vector2(-500, 300)
	othermob.position = Vector2(200, 500)
	add_child(mob_scene)
	add_child(othermob)
	emit_signal("mobPath")
	$ScoreLabel.text = ("Score: " + str(score))
	

# Press escape to quit the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
		

func _on_player_character_death():
	get_tree().change_scene_to_file("res://Scenes/Prototype Scenes/Start.tscn")


func _on_sword_hitbox_body_entered(body):
	if body.is_in_group("Enemys"):
		body.queue_free()
		emit_signal("enemykilled")


func _on_enemykilled():
	score += 1
	$ScoreLabel.text = ("Score: " + str(score))
