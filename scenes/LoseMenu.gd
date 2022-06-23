extends Node2D


func _on_ReturnButton_pressed():
	get_tree().change_scene("res://scenes/mainmenu.tscn")


func _on_RetryButton_pressed():
	get_tree().reload_current_scene()
