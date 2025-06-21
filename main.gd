extends Node2D
@export var cheese_scene: PackedScene
@export var cat_scene: PackedScene
@export var pause_icon: Texture
@export var play_icon: Texture
var cheese_count = 0
var lives = 3
var is_paused = false
var item_speed = 100  # Initial speed of cats and cheese
var level = 1
var last_safe_lanes = [0, 1]  # 0 = left, 1 = right. Both safe at the start.
var game_is_over = false

func _ready():
	get_tree().paused = false
	last_safe_lanes = [0, 1]
	$PauseButton.icon = pause_icon
	$CheeseLabel.text = "Score: %d" % cheese_count
	$LivesLabel.text = "Lives: %d" % lives
	$LevelLabel.text = "Level: %d" % level
	$CanvasLayer/StartPanel.visible = true
	$CanvasLayer/GameOverPanel.visible = false
	$CheeseLabel.visible = false
	$LivesLabel.visible = false
	$LevelLabel.visible = false
	$LevelUpLabel.visible = false
	$PauseButton.visible = false
	$LevelUpLabel.visible = false
	$SpawnTimer.stop()
	# Set cheese_scene in the Inspector to Cheese.tscn
	var left = $LaneLeft.position
	var right = $LaneRight.position
	$Player.left_pos = left
	$Player.right_pos = right
	$Player.position = left
	$Player.current_lane = "left"

#func _on_spawn_timer_timeout() -> void:
#	# Choose which lane to spawn in
#	var lane = $LaneLeft if randf() < 0.5 else $LaneRight
#	var cheese = cheese_scene.instantiate()
#	# Use the lane's X, and set Y to 0 (top of screen)
#	add_child(cheese)
#	print("Cheese pos:", cheese.position)
	
func _on_spawn_timer_timeout() -> void:
	var left_spawn = "empty"
	var right_spawn = "empty"
	var next_safe_lanes = []

	# Pick a safe lane based on last_safe_lanes
	var safe_lane = last_safe_lanes[randi() % last_safe_lanes.size()]

	# Decide the other lane content
	if safe_lane == 0:
		# Left is safe
		left_spawn = "empty"  # guarantee safe
		var r = randf()
		if r < 0.2:
			right_spawn = "cat"
		elif r < 0.7:
			right_spawn = "cheese"
		else:
			right_spawn = "empty"
	else:
		# Right is safe
		right_spawn = "empty"  # guarantee safe
		var r = randf()
		if r < 0.4:
			left_spawn = "cat"
		elif r < 0.7:
			left_spawn = "cheese"
		else:
			left_spawn = "empty"

	# SPAWN LEFT LANE
	if left_spawn == "cat":
		var cat = cat_scene.instantiate()
		cat.position = Vector2($LaneLeft.position.x, 0)
		cat.connect("hit", Callable(self, "_on_life_lost"))
		cat.speed = item_speed
		add_child(cat)
	elif left_spawn == "cheese":
		var cheese = cheese_scene.instantiate()
		cheese.position = Vector2($LaneLeft.position.x, 0)
		cheese.connect("collected", Callable(self, "_on_cheese_collected"))
		cheese.speed = item_speed
		add_child(cheese)

	# SPAWN RIGHT LANE
	if right_spawn == "cat":
		var cat = cat_scene.instantiate()
		cat.position = Vector2($LaneRight.position.x, 0)
		cat.connect("hit", Callable(self, "_on_life_lost"))
		cat.speed = item_speed
		add_child(cat)
	elif right_spawn == "cheese":
		var cheese = cheese_scene.instantiate()
		cheese.position = Vector2($LaneRight.position.x, 0)
		cheese.connect("collected", Callable(self, "_on_cheese_collected"))
		cheese.speed = item_speed
		add_child(cheese)

	# Determine which lanes are safe for the next spawn
	last_safe_lanes.clear()
	if left_spawn != "cat":
		last_safe_lanes.append(0)
	if right_spawn != "cat":
		last_safe_lanes.append(1)

	# Set next wait time to 1, 2, or 3 seconds randomly
	var times = [1, 1.2, 0.8]
	$SpawnTimer.wait_time = times[randi() % times.size()]
	$SpawnTimer.start()



func _on_cheese_collected():
	cheese_count += 1
	$CheeseLabel.text = "Score: %d" % cheese_count
	if cheese_count % 10 == 0:
		item_speed += 50  # Increase speed by 50 (adjust as needed)
		increase_level()
		print("Speed increased! New speed:", item_speed)

func _on_life_lost():
	get_tree().paused = true
	$PauseTimer.start(1.5)
	lives -= 1
	$LivesLabel.text = "Lives: %d" % lives
	if lives <= 0:
		game_over()

func game_over():
	# You can show a message, reset the level, etc.
	game_is_over = true
	$LivesLabel.text = "Lives: 0"
	print("Game Over!")
	$CanvasLayer/GameOverPanel.visible = true
	$SpawnTimer.stop()  # Stops new spawns
	get_tree().paused = true  # Pauses everything!

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func _on_pause_button_pressed():
	if not is_paused:
		get_tree().paused = true
		is_paused = true
		$PauseButton.icon= play_icon
	else:
		get_tree().paused = false
		is_paused = false
		$PauseButton.icon = pause_icon
		
func increase_level():
	level += 1
	$LevelLabel.text = "Level: %d" % level

	# Show level up message
	$LevelUpLabel.text = "Level %d!" % level
	$LevelUpLabel.visible = true
	await get_tree().create_timer(2).timeout
	$LevelUpLabel.visible = false

func _on_pause_timer_timeout():
	if not game_is_over:
		get_tree().paused = false


func _on_start_button_pressed():
	$CanvasLayer/StartPanel.visible = false
	$CheeseLabel.visible = true
	$LivesLabel.visible = true
	$LevelLabel.visible = true
	$LevelUpLabel.visible = false
	$PauseButton.visible = true
	$SpawnTimer.start()
	# Optionally, reset values if needed
