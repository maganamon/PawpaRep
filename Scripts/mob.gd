extends CharacterBody2D

var speed = 30  # Adjust the speed of the mob as needed
var player
var mob
 # Amount of damage the enemy will inflict on the player
var damage_dealt = 1
var health = 10
#preload the sprite textures
var right_sprite_texture = preload("res://addons/sprites/characters/bozo_bitch_right.png")
var left_sprite_texture = preload("res://addons/sprites/characters/bozo_bitch_left.png")
# Get the player's position
func _ready():
	#follow the player
	# Assuming Player is the root node of the player character
	player = get_node("/root/Game/ChrisPlayer") 
func _process(_delta):
	if player and not player.is_queued_for_deletion():
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		_update_sprite_direction(direction)
	else:
		pass
		
# Update the sprite direction based on the movement direction
func _update_sprite_direction(direction):
	var sprite = $Sprite2D  # Assuming the Sprite2D node is a child of the mob
	if direction.x > 0:
		sprite.texture = right_sprite_texture  # Use right sprite texture
	elif direction.x < 0:
		sprite.texture = left_sprite_texture   # Use left sprite texture
		
func take_damage():
	health -= 1
	if health == 0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage_mob"):
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage_dealt, push)
