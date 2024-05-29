extends CharacterBody2D

class_name Player

@onready var playersprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var deathflag = 0
var is_dead = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _on_game_manager_player_has_died(flag):
	if(is_dead == false):
		deathflag = flag
	else:
		deathflag = 3
	return

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip the Sprite to face the right direction
	
	if (direction < 0):
		playersprite.flip_h = true
	elif (direction > 0):
		playersprite.flip_h = false
	
	#Play animation
	if (deathflag == 0):
		is_dead = false
		if is_on_floor():
			if (direction == 0):
				playersprite.play("idle")
			else:
				playersprite.play("run")
		else:
			playersprite.play("jump")
		print (deathflag)
	elif (deathflag == 1 && is_dead == false):
		playersprite.play("death")
		is_dead = true
		print(deathflag)
	elif(deathflag == 2 && is_dead == false):
		is_dead = true
		print(deathflag)
	else:
		is_dead = true
		return

	# Set speed and apply movement
	if direction:
		velocity.x = direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()




