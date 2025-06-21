extends Node2D
@onready var bg1 = $Background1
@onready var bg2 = $Background2
@export var speed = 50

func _ready():
	bg1.position = Vector2(0, 120)
	bg2.position = Vector2(0, -bg1.texture.get_height()+150)
	#bg2.position = Vector2(0, -400)

func _process(delta):
	bg1.position.y += speed * delta
	bg2.position.y += speed * delta

	var bg_height = bg1.texture.get_height()
	# If a background goes offscreen, move it above the other one
	if bg1.position.y >= bg_height:
		bg1.position.y = bg2.position.y - bg_height
	if bg2.position.y >= bg_height:
		bg2.position.y = bg1.position.y - bg_height
