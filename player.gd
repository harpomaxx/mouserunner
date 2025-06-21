extends  Area2D

var left_pos = Vector2.ZERO
var right_pos = Vector2.ZERO
var current_lane = "left"

func _ready():
	# We'll set the real positions from the Main scene later
	pass

func _input(event):
	if event.is_action_pressed("move_left") and current_lane == "right":
		position = left_pos
		current_lane = "left"
	elif event.is_action_pressed("move_right") and current_lane == "left":
		position = right_pos
		current_lane = "right"
