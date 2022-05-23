extends Node2D

var hits: int

var timer = 1

var o_fwNode = load("res://scenes/FireworksNode.tscn")
var r_fwNode = load("res://scenes/PurpleFwNode.tscn")
export(Array, PackedScene) var Obstacles

var fwInst

var time_out = 1.5

var rng = RandomNumberGenerator.new()

var speedMult

const maximumSpeed: float = 2.00

var PB

func _ready():
	hits = 0
	speedMult = 1
	PB = get_node("/root/Scene/CanvasLayer/StressBar/ProgressBar")
	
func _physics_process(delta):
	timer += delta * speedMult
	if timer >= time_out:
		spawn_next()
		spawnObstacle()
		rng.randomize()
		var rand = rng.randf_range(-0.2, 0.3)
		time_out = 1 + rand
		timer = 0
		speedMult += 0.005
		speedMult = min(speedMult, maximumSpeed)
	if PB.value > 0 :
		PB.value -= delta * speedMult
	if PB.value >= 99:
		print("game over")
	

func spawn_next():
	var fwNode = null
	if rng.randi() % 2 == 0:
		fwNode = o_fwNode
	else:
		fwNode = r_fwNode
	fwInst = fwNode.instance()
	add_child(fwInst)
	fwInst.position.x = 900
	fwInst.position.y = 320

func spawnObstacle():
	if rng.randi() % 4 == 0:
		var id = rng.randi() % Obstacles.size()
		var obstacle = Obstacles[id].instance()
		add_child(obstacle)
		obstacle.position.x = get_viewport_rect().size.x + obstacle.get_node("Sprite").get_rect().size.x / 2
		obstacle.position.y = get_viewport_rect().size.y - obstacle.get_node("Sprite").get_rect().size.y / 2
