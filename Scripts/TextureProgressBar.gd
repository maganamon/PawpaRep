extends TextureProgressBar

var player 

func _ready():
	player = get_node("/root/Game/ChrisPlayer")  # Adjust the path to your player

func _process(_delta):
	value = (player.health * 10)
