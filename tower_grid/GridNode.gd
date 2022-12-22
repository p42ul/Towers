extends Area2D

var x
var y
var has_tower = false

signal tower_created(x, y)
signal tower_removed(x, y)

func _ready():
	$TowerSprite.hide()

func _input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("grid_draw"):
		create_tower()
	elif Input.is_action_pressed("grid_remove"):
		remove_tower()

func set_size(r: int):
	var sprite_size = 32
	$TowerSprite.position.x = r/2
	$TowerSprite.position.y = r/2
	$TowerSprite.scale = Vector2(r / sprite_size, r / sprite_size)
	$SpriteBorder.rect_size = Vector2(r, r)
	$CollisionShape2D.position.x = r/2
	$CollisionShape2D.position.y = r/2
	$CollisionShape2D.scale.x = r/2
	$CollisionShape2D.scale.y = r/2

func create_tower():
	if has_tower:
		return
	emit_signal("tower_created", x, y)
	$TowerSprite.show()
	has_tower = true

func remove_tower():
	if not has_tower:
		return
	emit_signal("tower_removed", x, y)
	$TowerSprite.hide()
	has_tower = false
