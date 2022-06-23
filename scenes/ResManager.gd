extends Node

const SAVE_PATH = "res://test_save/save.save"

func _ready():
	load_data()
	
func save_data():
	var file = File.new()
	var err = file.open(SAVE_PATH, File.WRITE)
	file.store_32(get_node("../CanvasLayer/Best").best)
	file.close()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_PATH):
		get_node("../CanvasLayer/Best").best = 0
		save_data()
	else:
		file.open(SAVE_PATH, File.READ)
		var value = file.get_32()
		get_node("../CanvasLayer/Best").best = value
	file.close()
