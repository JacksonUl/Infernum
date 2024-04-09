extends Area2D

func _ready():
	pass

func _process(delta):
	$CollisionShape2D.disabled = true
	
	if Input.is_action_pressed("Attak"):
		$CollisionShape2D.disabled = false
		
		
		
