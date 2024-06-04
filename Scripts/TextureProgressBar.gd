extends TextureProgressBar

var player
var newname = Player_Name.player_name
func _ready():
	player = get_node("/root/Game/ChrisPlayer")  # Adjust the path to your player node
	print("Level1 _ready() called")
	print("Player name from autoload: ", newname)
	var name_label = get_node('CanvasLayer/name_label')
	if name_label:
		name_label.text = newname
	else:
		print("Error: name_label not found")

func _process(_delta):
	value = (player.health * 10)
