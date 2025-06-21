extends Area2D
@export var collected_texture: Texture
#@export var speed = 100
@export var speed := 100  # The := syntax sets a default value, but Main will override it!

signal hit
func _process(delta):
	position.y += speed * delta
	if position.y > 720: # Or your window height
		queue_free()

func _on_area_entered(area):
	if area.name == "Player":
		hit.emit()
		$Sprite2D.texture = collected_texture
		print("WARNING! cat ")

		# Smoothly scale up and fade out over 0.3 seconds
		var time = 0.0
		var duration = 0.3
		var start_scale = $Sprite2D.scale * 0.7
		var end_scale = start_scale * 1
		var start_modulate = $Sprite2D.modulate
		var end_modulate = Color(start_modulate.r, start_modulate.g, start_modulate.b, 0.0)

		while time < duration:
			var t = time / duration
			$Sprite2D.scale = start_scale.lerp(end_scale, t)
			$Sprite2D.modulate = start_modulate.lerp(end_modulate, t)
			await get_tree().process_frame
			time += get_process_delta_time()
