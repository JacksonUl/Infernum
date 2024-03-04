extends Node2D

@onready var swordHitbox = $Area2D/CollisionShape2D
var swordlength = 30
var direction
var rotationAngle

func _ready():
	pass

func _process(delta):
	
	var col = get_node("Area2D/CollisionShape2D")
	col.set_disabled(true)
	
	direction = get_global_mouse_position() - global_position
	rotationAngle = direction.angle()
	rotation = rotationAngle
	swordHitbox.position = direction.normalized() * swordlength
	
	if Input.is_action_pressed("Attak"):
		col.set_disabled(false)
		get_tree().create_timer(0.5).timeout
		
		
		
		
		
