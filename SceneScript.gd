extends Node2D

var hits: int

var timer = 0

var fwNode = load("res://FireworksNode.tscn")

var fwInst

var time_out = 1

var rng = RandomNumberGenerator.new()

func _ready():
	hits = 0
	
func _process(delta):
	timer += delta
	if timer >= time_out:
		spawn_next()
		rng.randomize()
		var rand = rng.randf_range(-0.3, 0.3)
		time_out = 1 + rand
		timer = 0
	

func spawn_next():
	fwInst = fwNode.instance()
	add_child(fwInst)
	fwInst.position.x = 900
	fwInst.position.y = 320
