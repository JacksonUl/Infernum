extends Node2D

@onready var swordHitbox = $Area2D/CollisionShape2D
var swordlength = 30
var direction
var rotationAngle
signal damage

func _ready():
	pass

func _process(delta):
	
	var col = get_node("Area2D/CollisionShape2D")
	
	direction = get_global_mouse_position() - global_position
	rotationAngle = direction.angle()
	rotation = rotationAngle
	swordHitbox.position = direction.normalized() * swordlength
	


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("Attak"):
		emit_signal("damage")
