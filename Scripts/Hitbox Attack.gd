extends Node2D

@onready var swordHitbox = $Area2D/CollisionShape2D
var swordlength = 30
var direction
var rotationAngle
var newPoint

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = get_global_mouse_position() - global_position
	rotationAngle = direction.angle()
	rotation = rotationAngle
	swordHitbox.position = direction.normalized() * swordlength
	
	newPoint = rotationAngle - 90

func _input(event):
	if event.is_action_pressed("Attak"):
		set_process(!is_processing())
		while rotationAngle > newPoint:
			rotationAngle -=1
			rotation = rotationAngle
		
