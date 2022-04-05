extends KinematicBody2D

const GRAVITY = 600

var acceleration = Vector2(0,0)
var velocity = Vector2(0,0)

const TOP_VEL = 300
#const TOP_ACC = 5

const MARGIN = 60
const BOTTOM = 360 - MARGIN
const TOP = 0 + MARGIN

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
