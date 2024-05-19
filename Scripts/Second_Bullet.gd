extends Area2D

var speed = 750
var direction = Vector2.ZERO
var traveled_distance = 0
const MAX_DISTANCE = 500  # Adjust this value as needed

func _ready():
	# Set the initial direction towards the mouse
	direction = (get_global_mouse_position() - global_position).normalized()
	rotation = direction.angle()

func _physics_process(delta):
	# Move the bullet in the direction it was initially facing
	position += direction * speed * delta
	
	# Calculate the distance traveled by the bullet
	traveled_distance += speed * delta
	
	# Check if the bullet has traveled beyond the maximum distance
	if traveled_distance > MAX_DISTANCE:
		queue_free()
		
# Funct to destroy the bullet when it makes
# contact with an enemy
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
