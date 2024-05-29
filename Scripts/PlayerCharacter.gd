extends CharacterBody2D


signal attack
signal room0(area)
signal room1
signal room2
signal room3
signal death

var dir
var dashcooldown = 0
var dashing = false
var sprinting = false

func _input(event):
	
	if event.is_action_pressed("Attak"):
		if dir == "left":
			$PCSprite.play("SwLEFT")
			#dir = "none"
		if dir == "right":
			$PCSprite.play("SwRIGHT")
			#dir = "none"
		if dir == "down":
			$PCSprite.play("SwDOWN")
			
		if dir == "up":
			$PCSprite.play("SwUP")
	
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




	if event.is_action_pressed("Sprint"):
		if sprinting == false:
			sprinting = true
		elif sprinting == true:
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
	


func _on_door_1_area_entered(area):
	emit_signal("room1")

func _on_door_2_area_entered(area):
	emit_signal("room2")
	
func _on_door_3_area_entered(area):
	emit_signal("room3")
	
func _on_area_2d_area_entered(area):
	emit_signal("room0", area)
	


func _on_room_2out_area_entered(area):
	emit_signal("room0", area)


func _on_room_3out_area_entered(area):
	emit_signal("room0", area)
