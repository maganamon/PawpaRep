extends CharacterBody2D

var speed = 30  # Adjust the speed of the mob as needed
var player
var right_sprite_texture = preload("res://addons/sprites/characters/bozo_bitch_right.png")
var left_sprite_texture = preload("res://addons/sprites/characters/bozo_bitch_left.png")
# Get the player's position
func _ready():
	player = get_node("/root/Game/ChrisPlayer")  # Assuming Player is the root node of the player character
#follow the player
func _process(_delta):
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		_update_sprite_direction(direction)
		
# Update the sprite direction based on the movement direction
func _update_sprite_direction(direction):
	var sprite = $Sprite2D  # Assuming the Sprite2D node is a child of the mob
	if direction.x > 0:
		sprite.texture = right_sprite_texture  # Use right sprite texture
	elif direction.x < 0:
		sprite.texture = left_sprite_texture   # Use left sprite texture
