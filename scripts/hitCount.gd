extends Label

func _ready():
	self.text = "HIT COUNT: " + str(get_node("/root/Scene").hits)

func updateText():
	self.text = "HIT COUNT: " + str(get_node("/root/Scene").hits)
