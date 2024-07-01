extends Area2D

var healing = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.has_method("heal_player"):
		body.heal_player(healing)
	
