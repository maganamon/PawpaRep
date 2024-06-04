extends Node2D

var clown_mob = preload("res://Scenes/Base Mobs/Clown_Bozo.tscn")
var dog_mob = preload("res://Scenes/Base Mobs/cool_dog_mob.tscn")
var counter = 0
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_spawn_timer_timeout():
	var area = $Spawn1/SpawnArea
	var position_new = area.global_position + (Vector2(randf() * area.size.x, randf() * area.size.y))
	var enemy = clown_mob.instantiate()
	enemy.position = position_new
	add_child(enemy)
	counter += 1
	if counter % 3 == 0:
		var area2 = $Spawn2/SpawnArea
		var position_new2 = area2.global_position + (Vector2(randf() * area2.size.x, randf() * area2.size.y))
		var enemy2 = dog_mob.instantiate()
		enemy2.position = position_new2
		add_child(enemy2)
