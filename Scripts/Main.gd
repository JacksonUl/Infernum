extends Node2D

signal mobPath
signal enemyDamage(enemytype)
signal SpawnNew(newMob)

var mob_string = ""
var search_string = ""
var real_mob
var scene

var mobScenePaths = [
	preload("res://Scenes/1.tscn"),
	preload("res://Scenes/2.tscn"),
	preload("res://Scenes/3.tscn")
]
var mobInstances = []

func _ready():
	for path in mobScenePaths:
		var mobInstance = path.instantiate()
		mobInstances.append(mobInstance)
		mobInstance.add_to_group("Enemies")
		add_child(mobInstance) # Add the child here
		emit_signal("SpawnNew", mobInstance)
		spawnMobs()

func spawnMobs():
	for mob in mobInstances:
		add_child(mob)
# Press escape to quit the game
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_character_death():
	get_tree().change_scene_to_file("res://Scenes/Prototype Scenes/Start.tscn")

func _on_sword_hitbox_body_entered(body):
	if body.is_in_group("Enemies"):
		var mobIndex = mobInstances.find(body)
		mob_string = str(mobIndex)
		
		search_string = "0"
		if mob_string.find(search_string) != -1:
			real_mob = "res://Scenes/1.tscn"
		else:
			search_string = "1"
			if mob_string.find(search_string) != -1:
				real_mob = "res://Scenes/2.tscn"
			else:
				search_string = "2"
				if mob_string.find(search_string) != -1:
					real_mob = "res://Scenes/3.tscn"
				else:
					print("notFound")
					
		print(load(real_mob))
		body.queue_free()
		await get_tree().create_timer(3).timeout
		spawnNewMob(load(real_mob))

func spawnNewMob(index):
	var new_instance = index.instantiate()
	get_tree().get_root().add_child(new_instance)

  

	#print(mobInstances[index])
	#var newMob = mobInstances[index]
	#add_child(newMob)
	#emit_signal("SpawnNew", newMob)

