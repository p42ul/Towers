extends Area2D

var x
var y
var has_tower = false


func _input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("grid_draw"):
		create_tower()
	elif Input.is_action_pressed("grid_remove"):
		remove_tower()

func set_size(r: int):
	var sprite_size = 32
	$Tower.position.x = r/2
	$Tower.position.y = r/2
	$Tower.scale = Vector2(r / sprite_size, r / sprite_size)
	$GridBorderSprite.rect_size = Vector2(r, r)
	$CollisionShape2D.position.x = r/2
	$CollisionShape2D.position.y = r/2
	$CollisionShape2D.scale.x = r/2
	$CollisionShape2D.scale.y = r/2

func create_tower():
	if has_tower:
		return
	var path = GridController.try_create_tower(self.x, self.y)
	if path.size() > 0:
		$Tower.set_active(true)
		has_tower = true

func remove_tower():
	if not has_tower:
		return
	$Tower.set_active(false)
	has_tower = false
