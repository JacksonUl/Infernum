extends Node2D

@onready var swordHitbox = $Area2D/CollisionShape2D
var swordlength = 30
var direction
var rotationAngle

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = get_global_mouse_position() - global_position
	rotationAngle = direction.angle()
	rotation = rotationAngle
	swordHitbox.position = direction.normalized() * swordlength
