extends Node2D

signal mobPath
signal enemyDamage(enemytype)
signal SpawnNew(newMob)
signal killed


var mob_string = ""
var search_string = ""
var real_mob
var scene
var borders = []
var playerHealth = 100
var killcount = 0
var incriment = 0.5
var room = 0

var mobScenePaths = [
	preload("res://Scenes/1.tscn"),
	preload("res://Scenes/2.tscn"),
	preload("res://Scenes/3.tscn")
]
var mobInstances = []

@onready var player := $PlayerCharacter as Node2D

func _ready():
	$Level1.position.x = 3000
	$Level2.position.x = 6000
	$Level3.position.x = 9000
	spawnMobs()
	

func spawnMobs():
	emit_signal("killed")
	borders = []
	
	if room == 0:
		borders = [-200, 450]
	if room == 1:
		borders = [0, 1]
	if room == 2:
		borders = [-200, 450]
	if room == 3:
		borders = [-200, 450]
		
	for i in range(40):
		for path in mobScenePaths:
			var mobInstance = path.instantiate()
			mobInstances.append(mobInstance)
			mobInstance.add_to_group("Enemies")
			mobInstance.position = Vector2(randf_range(-750, -50), borders[randi() % borders.size()])
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
		if body.is_inside_tree():
			body.position = Vector2(randf_range(-750, 750), borders[randi() % borders.size()])
			body.show()


func _on_killed():
	$ScoreCounter.text = ("Score: "+ str(killcount))



func _on_player_health_area_entered(area):
	playerHealth -= 10
	$HealthCounter.text = ("Health: "+ str(playerHealth))
	if playerHealth <= 0:
		_on_player_character_death()


func _on_player_character_room_1():
	playerHealth+= 10
	$"Test Level".position.x = 3000
	$Level1.position.x = 0
	room = 1
	KillMobs()


func _on_player_character_room_2():
	playerHealth+= 10
	$"Test Level".position.x = 3000
	$Level2.position.x = 0
	room = 2
	KillMobs()


func _on_player_character_room_3():
	playerHealth+= 10
	$"Test Level".position.x = 3000
	$Level3.position.x = 0
	room = 3
	KillMobs()

func KillMobs():
	for i in mobInstances:
		i.queue_free()

	mobInstances.clear()


func _on_player_character_room_0(area):
	playerHealth+= 10
	$"Test Level".position.x = 0
	$Level2.position.x = 6000
	$Level1.position.x = 3000
	$Level3.position.x = 9000
	room = 0
	KillMobs()
