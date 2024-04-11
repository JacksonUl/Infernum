extends Area2D

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_pressed("Attak"):
		$CollisionShape2D.disabled = false
		
		
		
