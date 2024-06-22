extends Path2D

func _ready():
	GridController.connect("path_changed", Callable(self, "update_curve"))
	self.update_curve(GridController.recalculate_path())

func update_curve(path):
	self.curve.clear_points()
	for v in path:
		self.curve.add_point(v)
		
func _process(_delta):
	self.queue_redraw()

func _draw():
	if self.curve.get_baked_length() > 2:
		draw_polyline(self.curve.get_baked_points(), Color.AQUAMARINE, 5, true)
