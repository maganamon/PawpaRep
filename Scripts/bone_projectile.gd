extends Area2D

var speed = 450
var direction = Vector2.ZERO
var traveled_distance = 0
var damage_dealt = 1
const MAX_DISTANCE = 500  # Adjust this value as needed

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the player's position
	var player = get_node("/root/Game/ChrisPlayer")  # Adjust the path to your player node
	if player:
		# Calculate the direction from the projectile to the player
		direction = (player.global_position - global_position).normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called every physics frame.
func _physics_process(delta):
	# Move the bullet in the direction it was initially facing
	position += direction * speed * delta
	
	# Calculate the distance traveled by the bullet
	traveled_distance += speed * delta
	
	# Check if the bullet has traveled beyond the maximum distance
	if traveled_distance > MAX_DISTANCE:
		queue_free()

# Handle collision with other bodies
func _on_body_entered(body):
	if body.has_method("take_damage_mob"):
		var push = global_position.direction_to(body.global_position) * 0.5
		body.take_damage_mob(damage_dealt, push)
