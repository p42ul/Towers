extends Node2D

@export var line_width = 2.0
@export var radius = 0
@export var color = Color.WHITE
@export var filled = false

func _process(_delta):
	self.update()

func _draw():
	if self.filled:
		draw_circle(self.transform.get_origin(), self.radius, self.color)
	else:
		draw_arc(self.transform.get_origin(), self.radius, 0, 2*PI, 360, self.color, self.line_width, true)
