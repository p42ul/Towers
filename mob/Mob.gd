extends PathFollow2D

export var speed = 100

signal reached_end


func _process(delta):
	self.offset += delta * speed
	if self.unit_offset == 1.0:
		emit_signal("reached_end")
		self.queue_free()
