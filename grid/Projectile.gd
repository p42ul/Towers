extends Area2D

var direction = Vector2(0, 0)
export var speed = 500
export var damage = 1

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
	
func _draw():
	draw_circle(self.transform.get_origin(), self.scale.x, Color.white)

func _process(delta):
	self.position += direction*speed*delta
