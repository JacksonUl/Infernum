
extends CharacterBody2D


var speed = 1

var movement = Vector2.ZERO

var pressingup = 0
var pressingright = 0
var pressingdown = 0
var pressingleft = 0

var dashcooldown = 0


func _input(event):
	if event.is_action_pressed("Move_Left"):
		movement.x = -1
		pressingleft = 1
	if event.is_action_pressed("Move_Right"):
		movement.x = 1
		pressingright = 1
	if event.is_action_pressed("Move_Up"):
		movement.y = -1
		pressingup = 1
	if event.is_action_pressed("Move_Down"):
		movement.y = 1
		pressingdown = 1
			
			
	if event.is_action_released("Move_Left"):
		pressingleft = 0
		if movement.x == 1:
			pass
		else:
			movement.x = 0
			
	if event.is_action_released("Move_Right"):
		pressingright = 0
		if movement.x == -1:
			pass
		else:
			movement.x = 0
			
	if event.is_action_released("Move_Up"):
		pressingup = 0
		if movement.y == 1:
			pass
		else:
			movement.y = 0
			
	if event.is_action_released("Move_Down"):
		pressingdown = 0
		if movement.y == -1:
			pass
		else:
			movement.y = 0
			
			
	if event.is_action_pressed("Dash"):
		if dashcooldown == 0:
			movement = movement.normalized()
			position.x += movement.x * 100
			position.y += movement.y * 100
			dashcooldown = 1
			await get_tree().create_timer(1.5).timeout
			dashcooldown = 0
		else:
			pass

func _process(delta):
	velocity.x = movement.x*speed*delta
	velocity.y = movement.y*speed*delta
	velocity = velocity.normalized()
	velocity *= 200
	move_and_slide()
