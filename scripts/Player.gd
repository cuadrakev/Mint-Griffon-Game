extends KinematicBody2D

const GRAVITY = 200

var acceleration = Vector2(0,0)
var velocity = Vector2(0,0)

const TOP_VEL = 150
#const TOP_ACC = 5

const BOTTOM = 180
const TOP = -180

func conditional(cond: bool, val1, val2):
	if cond:
		return val1
	else:
		return val2

# Called when the node enters the scene tree for the first time.
#func _ready():
	#vel = 0
	#position = Vector2(100,180)

func _process(delta):
	acceleration.y = GRAVITY * conditional(Input.is_mouse_button_pressed(BUTTON_LEFT), -1, 1)
	velocity.y += acceleration.y * delta
	if(-TOP_VEL > velocity.y or velocity.y > TOP_VEL):
		velocity.y = TOP_VEL * conditional(velocity.y > 0, 1, -1)
	position.y += velocity.y * delta
	if(TOP > position.y or position.y > BOTTOM):
		velocity.y = 0
		position.y = 180 * conditional(position.y > 0, 1, -1)

