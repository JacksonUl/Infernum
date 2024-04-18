extends Area2D

func _ready():
	$CollisionShape2D.disabled = true

func _process(delta):
	
	if Input.is_action_pressed("Attak"):
		$CollisionShape2D.disabled = false
		await get_tree().create_timer(0.5).timeout
		$CollisionShape2D.disabled = true
		
		
		
