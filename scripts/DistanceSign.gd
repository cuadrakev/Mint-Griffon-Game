class_name DistanceSign
extends Sprite

export var screenSpeed = 2.0
export var screenDistanceDivider = 4.0
export var distanceMultiplyer = 100
var currentDistance = 0
var nextTriggerDistance = 500
onready var screenWidth = get_viewport_rect().size.x

func _ready():
	self.visible = false
	$Label.text = String(self.nextTriggerDistance) + "M"
	

func _process(delta):
	self.currentDistance += self.distanceMultiplyer * delta * get_node("/root/Scene").speedMult
	
	if not self.visible:
		if self.currentDistance + screenWidth / self.screenDistanceDivider >=\
		   nextTriggerDistance - self.get_rect().size.x / 2.0:
			self.position.x = screenWidth + self.get_rect().size.x / 2.0
			self.visible = true
	else:
		self.position.x -= self.screenSpeed * self.distanceMultiplyer * delta * get_node("/root/Scene").speedMult
		if self.position.x + self.get_rect().size.x / 2.0 <= 0:
			self.visible = false
			self.nextTriggerDistance += 500
			$Label.text = String(self.nextTriggerDistance) + "M"
	
