extends Control
var player_name
var btn_pressed_sprite = preload("res://addons/sprites/objects/Button_Pressed.png")

func _on_play_button_pressed():
	$Play_Button.texture_normal = btn_pressed_sprite
	player_name = $LineEdit.text
	if len(player_name) > 8:
		player_name = "DumbBozo"
	else:
		player_name = $LineEdit.text
	$menu_timer.start(2.0)
	await $menu_timer.timeout
	print(player_name)
	get_tree().change_scene_to_file("res://Scenes/Level1.tscn")
