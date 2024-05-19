extends Area2D

var travel_distance = 0
var speed = 750
# Have the bullet face the direction it is shooting
func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	const RANGE = 500
	position += direction * speed * delta
	travel_distance += speed * delta
#Destroy the bullet after some distance traveled
	if travel_distance > RANGE:
		queue_free()


# Funct to destroy the bullet when it makes
# contact with an enemy
func _on_Bullet_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()
