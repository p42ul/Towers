extends Area2D

var x
var y
var radius = 0
var tower = null

func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("select"):
		create_tower()
	elif Input.is_action_pressed("remove"):
		remove_tower()

func set_radius(r: int):
	self.radius = r
	$CollisionShape2D.position.x = r
	$CollisionShape2D.position.y = r
	$CollisionShape2D.scale.x = r
	$CollisionShape2D.scale.y = r

func create_tower():
	if tower != null:
		return
	if GridController.try_create_tower(self.x, self.y):
		var tower = BuildTools.tower.instantiate()
		self.add_child(tower)
		self.tower = tower

func remove_tower():
	if tower == null:
		return
	GridController.remove_tower(self.x, self.y)
	self.tower.queue_free()
	self.tower = null
