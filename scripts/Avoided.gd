extends Label

var avoided
var total

func _ready():
	self.text = "Avoided: 0"
	avoided = 0
	total = 0

func updateText():
	total += 1
	avoided = total - get_node("/root/Scene").hits
	self.text = "Avoided: " + str(avoided)
	var current_best = get_node("../Best").best
	if avoided > current_best:
		get_node("../Best").best = avoided
		get_node("../Best").updateText()
