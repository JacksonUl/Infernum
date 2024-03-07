extends Node2D

@onready var swordHitbox = $Area2D/CollisionShape2D

var tween
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
	
	if Input.is_action_just_pressed("Attak"):
		#$AnimationPlayer.play("Shing Shing")
		if rotation > 90 and rotation < 270:
			newTween()
			tween.tween_property($Area2D, "rotation", deg_to_rad(-90), 1)
			
		else:
			newTween()
			tween.tween_property($Area2D, "rotation", deg_to_rad(90), 1)
			
			
		

func newTween():
	tween = create_tween()
	#get_tree().create_timer(desired value)
	tween.kill()


func _on_area_2d_body_entered(body):
	if Input.is_action_just_pressed("Attak"):
		emit_signal("damage")


