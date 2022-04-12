extends Label

var avoided

func _ready():
	self.text = "Avoided: 0"
	avoided = 0

func updateText():
	avoided += 1
	self.text = "Avoided: " + str(avoided - get_node("/root/Scene").hits)
