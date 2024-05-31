extends CharacterBody2D

var projectile_scene = preload("res://Scenes/Obstacles/bone_projectile.tscn")
var player
const SHOOT_INTERVAL = 1.2  # Adjust this value to control the rate of fire
var shooting_timer

 # Amount of damage the enemy will inflict on the player
var damage_dealt = 1
var health = 15
#preload the sprite textures
var right_sprite_texture = preload("res://addons/sprites/characters/smoking_dog_right.png")
var left_sprite_texture = preload("res://addons/sprites/characters/smoking_dog_left.png")

func _ready():
	#follow the player
	# Assuming Player is the root node of the player character
	player = get_node("/root/Game/ChrisPlayer")
	shooting_timer = $ShootingTimer  # Assuming the Timer node is named ShootingTimer
	shooting_timer.wait_time = SHOOT_INTERVAL
	shooting_timer.start()
	
func _update_sprite_direction():
	if player:
		var direction_pl = global_position.direction_to(player.global_position)
		var sprite = $Sprite2D  # Assuming the Sprite2D node is a child of the mob
		if direction_pl.x > 0:
			sprite.texture = right_sprite_texture  # Use right sprite texture
		elif direction_pl.x < 0:
			sprite.texture = left_sprite_texture   # Use left sprite texture

func take_damage():
	health -= 1
	if health == 0:
		queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("take_damage_mob"):
		var push = global_position.direction_to(body.global_position)
		body.take_damage_mob(damage_dealt, push)
		
func _process(_delta):
	if player:
		_update_sprite_direction()
		
func shoot():
	const BULLET = preload("res://Scenes/Obstacles/bone_projectile.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.position = %Bone_Marker.global_position #marker's gpos
	get_parent().add_child(new_bullet)
	shooting_timer.start()


func _on_shooting_timer_timeout():
	if player:
		shoot()
