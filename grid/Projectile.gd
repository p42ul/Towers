extends Area2D

var direction = Vector2(0, 0)
var speed = 100
var damage = 1

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()

func _process(delta):
	self.position += direction*speed*delta
