extends TextureProgressBar

var player 

func _ready():
	player = get_node("/root/Game/ChrisPlayer")  # Adjust the path to your player
	var newname = Player_Name.player_name

func _process(_delta):
	value = (player.health * 10)
