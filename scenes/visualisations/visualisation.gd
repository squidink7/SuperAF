extends SubViewportContainer

func _process(delta: float):
	# Scale content to fit, keeping aspect ratio
	var zoom_scale = (%Viewport.size as Vector2) / Vector2(1152,648)
	var max_zoom_axis = max(zoom_scale.x, zoom_scale.y)
	%Camera.zoom = Vector2(max_zoom_axis, max_zoom_axis)

func success():
	%Animation.play('success')

func fail():
	%Animation.play('fail')
