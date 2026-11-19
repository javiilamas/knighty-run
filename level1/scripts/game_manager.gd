extends Node

var current_level=1
var levels_path="res://scenes/Levels/"
func next_level():
	current_level+=1
	var full_path= levels_path + "world" + str(current_level) + ".tscn"
	get_tree().change_scene_to_file(full_path) 
	print("the player ends the level")
