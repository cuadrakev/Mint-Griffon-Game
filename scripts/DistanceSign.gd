class_name DistanceSign
extends Sprite

var currentDistance = 0
var distanceMultiplyer = 100
var nextTriggerDistance = 500
var isVisible = false
onready var screenWidth = get_viewport_rect().size.x


func _process(delta):
	self.currentDistance += self.distanceMultiplyer * delta * get_node("/root/Scene").speedMult
	
	if not self.isVisible:
		if self.currentDistance + screenWidth / 4.0 >= nextTriggerDistance:
			self.position.x = screenWidth
			self.isVisible = true
	else:
		self.position.x -= self.distanceMultiplyer * delta * get_node("/root/Scene").speedMult
		if self.position.x < 0:
			self.isVisible = false
			self.nextTriggerDistance += 500
			$Label.text = String(self.nextTriggerDistance) + "M"
	
