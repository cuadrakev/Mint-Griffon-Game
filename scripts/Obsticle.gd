extends Area2D

export var speed = 200


func _process(delta):
	var currentSpeed = get_node("/root/Scene").speedMult
	self.position.x -= speed * delta * currentSpeed
	
	if self.position.x + $Sprite.get_rect().size.x < 0:
		queue_free()

func onBodyEnter(body):
	if body.name == "BirdPlayer":
		body.position.y = self.position.y - $Sprite.get_rect().size.y
		get_node("/root/Scene/CanvasLayer/StressBar/ProgressBar").value += 20

