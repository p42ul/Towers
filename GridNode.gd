extends Area2D

var has_tower = false

func _input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("grid_draw"):
		create_tower()
	elif Input.is_action_pressed("grid_remove"):
		remove_tower()
		
func set_size(r: int):
	$ColorRect.rect_size = Vector2(r, r)
	$ColorRect.margin_right = r
	$ColorRect.margin_bottom = r
	$ReferenceRect.margin_right = r-1
	$ReferenceRect.margin_bottom = r-1
	$CollisionShape2D.position.x = r/2
	$CollisionShape2D.position.y = r/2
	$CollisionShape2D.scale.x = r/2
	$CollisionShape2D.scale.y = r/2

func create_tower():
	$ColorRect.color = Color.rosybrown
	
func remove_tower():
	$ColorRect.color = Color.white
