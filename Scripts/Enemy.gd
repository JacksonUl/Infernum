extends CharacterBody2D

const speed = 150
var enemyHealth = 20

signal hit

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D

func _ready() -> void:
	makepath()

func _physics_process(_delta: float) -> void:
	await get_tree().create_timer(.000000000001).timeout
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed 
	move_and_slide()
	
func makepath() -> void:
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	makepath()

func _on_area_2d_body_entered(body):
	emit_signal("hit")
		
func takeDamage(damage):
	enemyHealth -= damage
	print(enemyHealth)
	if enemyHealth <= 0:
		self.hide()


func _on_hitbox_area_entered(area):
	takeDamage(10)
