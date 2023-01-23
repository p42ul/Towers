extends Area2D

var x
var y
var has_tower = false

func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("grid_draw"):
		create_tower()
	elif Input.is_action_pressed("grid_remove"):
		remove_tower()

func set_radius(r: int):
	$Tower.set_radius(r)
	$CollisionShape2D.position.x = r/2
	$CollisionShape2D.position.y = r/2
	$CollisionShape2D.scale.x = r
	$CollisionShape2D.scale.y = r
	$Outline.rect_size = Vector2(r*2, r*2)

func create_tower():
	if has_tower:
		return
	if GridController.try_create_tower(self.x, self.y):
		$Tower.set_active(true)
		has_tower = true

func remove_tower():
	if not has_tower:
		return
	GridController.remove_tower(self.x, self.y)
	$Tower.set_active(false)
	has_tower = false
