extends Node2D

export var line_width = 2.0
var radius = 0
var is_active = false

func set_radius(r: int):
	self.position.x = r/2
	self.position.y = r/2
	self.radius = r

func _process(_delta):
	self.update()

func _draw():
	if self.is_active:
		draw_arc(self.transform.get_origin(), self.radius, 0, 2*PI, 360, Color.white, self.line_width, true)
