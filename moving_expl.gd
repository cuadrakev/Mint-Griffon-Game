extends Node2D

const SPEED = 200

func _process(delta):
	position.x -= SPEED * delta
	if position.x < -50 :
		position.x = 800
