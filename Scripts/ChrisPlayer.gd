extends CharacterBody2D

# Speed constant defining how fast the player moves
const speed = 100
# Variable to store the current direction of the player
var currentDirection = "none"
# Track if left mouse button is currently pressed
var can_shoot = true
# Adjust this value to control the rate of fire
var shooting_cooldown = 0.2
# Called when the node is added to the scene
var knockback_pos1 = Vector2.ZERO  # To store knockback velocity
var knockback_target = Vector2.ZERO
var knockback_decay = 0.0

#health
var health_max = 10
var health = health_max

func _ready():
	
	# Play the front idle animation when the game starts
	$AnimatedSprite2D.play("front_idle")

# This function is called every physics frame (fixed timestep)
func _physics_process(delta):
	# Handle player movement based on input
	player_movement(delta)
	knockback_decay = (delta * 3)
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
	var animation = $AnimatedSprite2D
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
	#Create a Bullet on Marker
		const BULLET = preload("res://Scenes/ProjectileII.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.position = %Bullet_Marker.global_position #marker's gpos
		get_parent().add_child(new_bullet)
		
func _process(_delta):
	var pos = global_position  # Get the global position of the player

	# Pass player's global position to the marker script
	$Bullet_Marker.update_position(pos)
	
## Shooting Logic starts Here:
########################################################
	# Check if left mouse button is pressed
	if can_shoot && Input.is_action_pressed("shoot"):
		# Start shooting
		shoot()
		
		can_shoot = false
		$Timer.start(shooting_cooldown)
		
func _on_timer_timeout():
	can_shoot = true
	
# Health mechanics start here:
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Function to take damage
func take_damage_mob(dmg_amt, pushed):
	# Apply knockback
	var player = get_node("/root/Game/ChrisPlayer")
	knockback_target = Vector2.ZERO + (pushed * 1000)
	player.global_position = player.global_position.lerp(knockback_target, knockback_decay)  # Reduce knockback over time
	

	health -= dmg_amt # Reduce current health by damage amount
	if health <= 0:
		health = 0
		die()  # Call the die function if health reaches 0

# Function to handle player death
func die():
	print("Player has died.")
	# You can add additional logic here, like playing a death animation,
	# restarting the level, or showing a game over screen.
	queue_free()  # Remove the player from the scene
	# After a delay, you might want to restart the level or show a game over screen
	await get_tree().create_timer(1.0).timeout
	# Here you can restart the level or show a game over screen
	get_tree().reload_current_scene()
