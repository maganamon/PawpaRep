extends CharacterBody2D

# Speed constant defining how fast the player moves
const speed = 100

# Variable to store the current direction of the player
var currentDirection = "none"

# Called when the node is added to the scene
func _ready():
	# Play the front idle animation when the game starts
	$CollisionShape2D/AnimatedSprite2D.play("front_idle")

# This function is called every physics frame (fixed timestep)
func _physics_process(delta):
	# Handle player movement based on input
	player_movement(delta)

# Function to handle player movement input and apply velocity
func player_movement(_delta):
	if Input.is_action_pressed("new_right"):
		currentDirection = "right"  # Set current direction to right
		playAnimation(1)  # Play walking animation
		velocity.x = speed  # Set velocity to move right
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_left"):
		currentDirection = "left"  # Set current direction to left
		playAnimation(1)  # Play walking animation
		velocity.x = -speed  # Set velocity to move left
		velocity.y = 0  # Stop vertical movement
	elif Input.is_action_pressed("new_down"):
		currentDirection = "down"  # Set current direction to down
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = speed  # Set velocity to move down
	elif Input.is_action_pressed("new_up"):
		currentDirection = "up"  # Set current direction to up
		playAnimation(1)  # Play walking animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = -speed  # Set velocity to move up
	else:
		playAnimation(0)  # Play idle animation
		velocity.x = 0  # Stop horizontal movement
		velocity.y = 0  # Stop vertical movement
	
	# Move the character based on the velocity vector
	move_and_slide()

# Function to play the appropriate animation based on direction and movement state
func playAnimation(movement):
	var direction = currentDirection  # Get the current direction
	var animation = $CollisionShape2D/AnimatedSprite2D
	  # Get the AnimatedSprite2D node
	
	if direction == "right":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("side_walk")  # Play walking animation for right
		elif movement == 0:
			animation.play("side_idle")  # Play idle animation for right
	elif direction == "left":
		animation.flip_h = true  # Flip sprite horizontally
		if movement == 1:
			animation.play("side_walk")  # Play walking animation for left
		elif movement == 0:
			animation.play("side_idle")  # Play idle animation for left
	elif direction == "down":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("front_walk")  # Play walking animation for down
		elif movement == 0:
			animation.play("front_idle")  # Play idle animation for down
	elif direction == "up":
		animation.flip_h = false  # Ensure sprite is not flipped horizontally
		if movement == 1:
			animation.play("back_walk")  # Play walking animation for up
		elif movement == 0:
			animation.play("back_idle")  # Play idle animation for up


#   Shootiing Mechanics Start Here:
#  ++++++++++++++++++++++++++++++++++++++++++++++++++++++
#Shoot Function
func shoot():
	const BULLET = preload("res://Scenes/ProjectileII.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.position = %Bullet_Marker.global_position #marker's gpos
	get_parent().add_child(new_bullet)
func _process(_delta):
	var pos = global_position  # Get the global position of the player
	print("Player" + str(pos))

	# Pass player's global position to the marker script
	$Bullet_Marker.update_position(pos)
	if Input.is_action_just_pressed("shoot"):
		shoot()
	



