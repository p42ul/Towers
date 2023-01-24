extends Node2D

export var width = 0
export var height = 0
export var color = Color.red
export var filled = false
export var line_width = 1.0
export var is_active = true

func _process(_delta):
	self.update()

func _draw():
	draw_rect(Rect2(0, 0, self.width, self.height), self.color, self.filled, self.line_width)
