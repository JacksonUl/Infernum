extends CharacterBody2D


signal attack

var dir
var dashcooldown = 0
var dashing = false
var sprinting = false

func _input(event):
	if event.is_action_pressed("Move_Left"):
		velocity.x = -200
		$PCSprite.play("Left")
		dir = "left"
		
	if event.is_action_pressed("Move_Right"):
		velocity.x = 200
		$PCSprite.play("Right")
		dir = "right"
		
	if event.is_action_pressed("Move_Up"):
		velocity.y = -200
		$PCSprite.play("Up")
		dir = "up"

	if event.is_action_pressed("Move_Down"):
		velocity.y = 200
		$PCSprite.play("Down")
		dir = "down"


	if event.is_action_released("Move_Left"):
		if velocity.x == 200:
			pass
		else:
			velocity.x = 0

	if event.is_action_released("Move_Right"):
		if velocity.x == -200:
			pass
		else:
			velocity.x = 0
	if event.is_action_released("Move_Up"):
		if velocity.y == 200:
			pass
		else:
			velocity.y = 0
	if event.is_action_released("Move_Down"):
		if velocity.y == -200:
			pass
		else:
			velocity.y = 0


	if event.is_action_pressed("Dash"):
		if dashcooldown == 0:
			dashing = true
			await get_tree().create_timer(.125).timeout
			dashing = false
			dashcooldown = 1
			await get_tree().create_timer(1.5).timeout
			dashcooldown = 0
			
		else:
			pass
			
			
	if event.is_action_pressed("Attack"):
		if dir == "right":
			$Sword.position.x = self.position.x
			$Sword.position.y = self.position.y
			
			print(self.position.y)
		$Sword.show()
		emit_signal("attack")
		print(dir)

		

	if event.is_action_pressed("Sprint"):
		sprinting = true
	if event.is_action_released("Sprint"):
		sprinting = false

func _process(_delta):
	velocity = velocity.normalized()
	if dashing == true:
		velocity *= 1500
	elif sprinting == true:
		velocity *= 300
	else:
		velocity *= 200
	move_and_slide()
	
	
