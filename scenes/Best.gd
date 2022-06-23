extends Label

var best: int = 0

func _ready():
	get_node("../../ResManager").load_data()
	updateText()
	
func updateText():
	self.text = "Best: " + str(best)

