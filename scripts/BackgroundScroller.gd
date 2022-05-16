class_name BackgroundScroller
extends ParallaxBackground

export(Array, Texture) var BackgroundTextures
#seams are in order: 1->2, 2->3, ..., n->1
export(Array, Texture) var BackgroundSeams
export var switchAfter = 2.0

var scrollSpeed = 200
var textureWidth = 0

var currentTexture = 0
var currentCycle = 0
onready var BgNode = $Background
onready var SeamNode = $Seam
onready var screenSize = get_viewport().size

func _ready():
	assert(BackgroundTextures.size() >= 2)
	assert(BackgroundSeams.size() == BackgroundTextures.size())

	var texToScreen = BackgroundTextures[0].get_height() / 360.0
	self.scale.x = 1.0 / texToScreen
	self.scale.y = 1.0 / texToScreen
	
	textureWidth = BackgroundTextures[0].get_width()
	switchAfter *= textureWidth
	
	BgNode.get_node("Sprite").texture = BackgroundTextures[0]
	BgNode.motion_mirroring.x = textureWidth
	SeamNode.visible = false

func _process(delta):
	self.scroll_offset.x -= scrollSpeed * delta * get_node("/root/Scene").speedMult
	
	if currentCycle == 0 and -self.scroll_offset.x > switchAfter:
		SeamNode.get_node("Sprite").texture = BackgroundSeams[currentTexture]
		SeamNode.motion_offset.x = switchAfter
		SeamNode.visible = true
		BgNode.motion_offset.x = switchAfter - textureWidth
		BgNode.motion_mirroring.x = 0
		currentCycle = 1
		
		currentTexture += 1
		if currentTexture == BackgroundTextures.size():
			currentTexture = 0
	
	if currentCycle == 1 and -self.scroll_offset.x > switchAfter + 2 * textureWidth:
		BgNode.get_node("Sprite").texture = BackgroundTextures[currentTexture]
		BgNode.motion_offset.x = switchAfter + textureWidth
		currentCycle = 2
	
	if currentCycle == 2 and -self.scroll_offset.x > switchAfter + 4 * textureWidth:
		self.scroll_offset.x = 0
		BgNode.motion_offset.x = 0
		BgNode.motion_mirroring.x = textureWidth
		SeamNode.visible = false
		currentCycle = 0
