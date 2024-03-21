class_name FPSLabel extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var fps : int = int(1.0 / delta)
	text = "FPS: " + str(fps)
