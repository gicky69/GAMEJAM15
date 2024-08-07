extends CharacterBody2D

var SPEED = 200.0
const JUMP_VELOCITY = -700.0
var jump_damping = 30.0 # The rate at which the jump velocity is reduced
var light = true

@onready var sprite_2d = $Sprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Smoothly stop the jump velocity when the jump button is released.
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y = lerp(velocity.y, 0.0, jump_damping * delta)
	
	if Input.is_action_pressed("sprint"):
		$Sprite2D.speed_scale = 2
		SPEED = 300.0
	else:
		$Sprite2D.speed_scale = 1
		SPEED = 200.0
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 50)
	
	# Move and slide with the current velocity
	move_and_slide()  # No arguments needed here

	# Determine sprite orientation based on velocity
	var isLeft
	if velocity.x != 0:
		isLeft = velocity.x < 0
		sprite_2d.flip_h = isLeft
		sprite_2d.animation = "running"
	else:
		if light:
			sprite_2d.animation = "idleLight"
		else:
			sprite_2d.animation = "dark-idle"
	
	if velocity.y != 0:
		sprite_2d.animation = "jumping"
		if velocity.y > 0:
			$Sprite2D.frame = 1
		else:
			$Sprite2D.frame = 0
