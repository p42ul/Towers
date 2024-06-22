extends Area2D

var direction = Vector2(0, 0)
@export var speed = 450
@export var damage = 1

func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
	
func _draw():
	draw_circle(Vector2.ZERO, self.scale.x, Color.WHITE)

func _process(delta):
	self.position += direction*speed*delta
