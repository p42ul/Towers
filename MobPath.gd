extends Path2D

func _ready():
	GridController.connect("path_changed", self, "update_curve")

func update_curve(path):
	self.curve.clear_points()
	for v in path:
		self.curve.add_point(v)

func _draw():
	draw_polyline(self.curve.get_baked_points(), Color.aquamarine, 5, true)
