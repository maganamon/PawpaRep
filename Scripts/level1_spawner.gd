extends Node2D
var round1 = true
var round2 = false
var round3 = false
var round4 = false
var able_to_spawn = true

var clown_mob = preload("res://Scenes/Base Mobs/Clown_Bozo.tscn")
var dog_mob = preload("res://Scenes/Base Mobs/cool_dog_mob.tscn")
var health_pack = preload("res://Scenes/battery_v_2.tscn")
var counter = 0
# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Player_Name.kill_counter == 20:
		able_to_spawn = false
		round1 = false
		print("end of round 1")

func _on_spawn_timer_timeout():
	if able_to_spawn == true:
		var area = $Spawn1/SpawnArea
		var position_new = area.global_position + (Vector2(randf() * area.size.x, randf() * area.size.y))
		var enemy = clown_mob.instantiate()
		enemy.position = position_new
		add_child(enemy)
		#######
		if 1 == 1:
			var area3 = $Spawn_Health/SpawnArea
			var position_new3 = area3.global_position + (Vector2(randf() * area3.size.x, randf() * area3.size.y))
			var health_pickup = health_pack.instantiate()
			health_pickup.global_position = position_new3
			print("spwned health")
			print(health_pickup.position)
		########
		counter += 1
		if counter % 4 == 0:
			var area2 = $Spawn2/SpawnArea
			var position_new2 = area2.global_position + (Vector2(randf() * area2.size.x, randf() * area2.size.y))
			var enemy2 = dog_mob.instantiate()
			enemy2.position = position_new2
			add_child(enemy2)
		if counter % 8 == 0:
			var area3 = $Spawn_Health/SpawnArea
			var position_new3 = area3.global_position + (Vector2(randf() * area3.size.x, randf() * area3.size.y))
			var health_pickup = health_pack.instantiate()
			health_pickup.position = position_new3
			print("spwned health")
			print(health_pickup.position)
