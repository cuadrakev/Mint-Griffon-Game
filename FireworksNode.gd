extends Node2D

var rng = RandomNumberGenerator.new()

const SPEED = 200
const GRAVITY = 600

const baseVel = 400
var variance = 120
var initVel

func _ready():
	rng.randomize()
	initVel = rng.randf_range(baseVel - variance, baseVel + variance)

func _process(delta):
	position.x -= SPEED * delta
	if position.x < -50 :
		queue_free()
	if position.x < 500 and get_node("Explosion").visible == false:
		position.y -= initVel * delta
		initVel -= GRAVITY * delta
		if initVel <= 0:
			get_node("Explosion").visible = true
			get_node("Sprite").visible = false


func _on_Area2D_body_entered(_body):
	get_node("/root/Scene").hits += 1
	get_node("/root/Scene/CanvasLayer/HitCount").updateText()
