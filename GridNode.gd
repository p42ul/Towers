extends Area2D

var x
var y
var last_color
var has_tower = false

signal tower_created(x, y)
signal tower_removed(x, y)

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
	if has_tower:
		return
	$ColorRect.color = Color.rosybrown
	emit_signal("tower_created", x, y)
	has_tower = true
	
	
func remove_tower():
	if not has_tower:
		return
	$ColorRect.color = Color.white
	emit_signal("tower_removed", x, y)
	has_tower = false

func flash_color(color):
	last_color = $ColorRect.color
	$ColorRect.color = color
	$ColorResetTimer.start()

func _on_color_reset_color():
	$ColorRect.color = last_color
