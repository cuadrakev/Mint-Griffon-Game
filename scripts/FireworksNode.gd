extends Node2D

var rng = RandomNumberGenerator.new()

const SPEED = 200
const GRAVITY = 600

const baseVel = 400
var variance = 140
var initVel

var flag = true

export var startPos: float

func _ready():
	rng.randomize()
	initVel = rng.randf_range(baseVel - variance, baseVel + variance)

func _process(delta):
	var mult = get_node("/root/Scene").speedMult
	position.x -= SPEED * delta * mult
	if position.x < 200 and flag:
		get_node("/root/Scene/CanvasLayer/Avoided").updateText()
		flag = false
	if position.x < -50 :
		queue_free()
	if position.x < startPos and get_node("Explosion").visible == false:
		if not get_node("SwooshPlayer").playing:
			get_node("SwooshPlayer").pitch_scale += rng.randf_range(0.9, -0.2)
			get_node("SwooshPlayer").play()
		position.y -= initVel * delta * mult
		initVel -= GRAVITY * delta * mult
		if initVel <= 0:
			get_node("Explosion").visible = true
			get_node("Sprite").visible = false
			get_node("ExplosionPlayer").play()
			get_node("SwooshPlayer").stop()


func _on_Area2D_body_entered(_body):
	get_node("/root/Scene").hits += 1
	get_node("/root/Scene/CanvasLayer/HitCount").updateText()
	get_node("/root/Scene/CanvasLayer/StressBar/ProgressBar").value += 40
