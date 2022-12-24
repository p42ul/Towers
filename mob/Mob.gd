extends PathFollow2D

export var speed = 100
export var health = 50

signal reached_end


func _process(delta):
	self.offset += delta * speed
	if self.unit_offset == 1.0:
		emit_signal("reached_end")
		self.queue_free()

func _on_projectile_area_entered(area):
	if not area.is_in_group("projectile"):
		return
	area.queue_free()
	self.health -= area.damage
	if self.health <= 0:
		self.queue_free()
