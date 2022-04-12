class_name BirdPlayer
extends KinematicBody2D

export var GRAVITY = 600
export var MARGIN = 60
export var TOP_VEL = 300

onready var BOTTOM = get_viewport_rect().size.y - MARGIN
onready var TOP = 0 + MARGIN

var acceleration = Vector2(0,0)
var velocity = Vector2(0,0)
onready var animSprite = $BirdSprite

#const TOP_ACC = 5

func _ready():
	get_child(2).make_current()

func conditional(cond: bool, val1, val2):
	if cond:
		return val1
	else:
		return val2

func _process(delta):
	#var mult = get_node("/root/Scene").speedMult
	acceleration.y = GRAVITY * conditional(Input.is_mouse_button_pressed(BUTTON_LEFT), -1, 1)
	velocity.y += acceleration.y * delta * 1.5
	if(-TOP_VEL > velocity.y or velocity.y > TOP_VEL):
		velocity.y = TOP_VEL * conditional(velocity.y > 0, 1, -1)
	position.y += velocity.y * delta * 1.5
	if(TOP > position.y or position.y > BOTTOM):
		velocity.y = 0
		position.y = 180 + (180 - MARGIN) * conditional(position.y > 180, 1, -1)
	rotation = velocity.y/600
	
	if(acceleration.y < 0):
		animSprite.play()
	else:
		animSprite.stop()
