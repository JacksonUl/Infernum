extends Node2D

signal mobPath
signal enemyDamage(enemytype)
signal SpawnNew(newMob)
signal killed


var mob_string = ""
var search_string = ""
var real_mob
var scene
var borders = [-200, 450]
var playerHealth = 100
var killcount = 0
var incriment = 0.5

var mobScenePaths = [
	preload("res://Scenes/1.tscn"),
	preload("res://Scenes/2.tscn"),
	preload("res://Scenes/3.tscn")
]
var mobInstances = []

@onready var player := $PlayerCharacter as Node2D

func _ready():
	emit_signal("killed")
	for i in range(40):
		for path in mobScenePaths:
			var mobInstance = path.instantiate()
			mobInstances.append(mobInstance)
			mobInstance.add_to_group("Enemies")
			mobInstance.position = Vector2(randf_range(-750, 750), borders[randi() % borders.size()])
			add_child(mobInstance)
			emit_signal("SpawnNew", mobInstance)
			await get_tree().create_timer(randf_range(0.1 + incriment, 0.5 + incriment)).timeout

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_character_death():
	get_tree().change_scene_to_file("res://Scenes/Prototype Scenes/Start.tscn")

func _on_sword_hitbox_body_entered(body):
	if body.is_in_group("Enemies"):
		incriment -= 0.01
		var mobIndex = mobInstances.find(body)
		mob_string = str(mobIndex)
		killcount += 1
		emit_signal("killed")
		

		search_string = "0"
		if mob_string.find(search_string) != -1:
			real_mob = load("res://Scenes/1.tscn")
		else:
			search_string = "1"
			if mob_string.find(search_string) != -1:
				real_mob = load("res://Scenes/2.tscn")
			else:
				search_string = "2"
				if mob_string.find(search_string) != -1:
					real_mob = load("res://Scenes/3.tscn")
	
					
		body.hide()
		await get_tree().create_timer(0.5).timeout
		body.position = Vector2(randf_range(-750, 750), borders[randi() % borders.size()])
		body.show()


func _on_killed():
	$ScoreCounter.text = ("Score: "+ str(killcount))



func _on_player_health_area_entered(area):
	playerHealth -= 10
	$HealthCounter.text = ("Health: "+ str(playerHealth))
