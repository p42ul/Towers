extends Node2D

var width = 24
var height = 12

var start_grid_id = width*height + 1
var end_grid_id = width*height + 2

var grid_node_size = 32

var grid = []
var aStar
var valid_path = false

var follower

export(PackedScene) var grid_node

func _ready():
	follower = $MobPath/MobPathFollower
	aStar = AStar2D.new()
	aStar.reserve_space(width*height+2)
	grid.resize(width*height)
	aStar.add_point(start_grid_id, Vector2(-grid_node_size, height/2))
	aStar.add_point(end_grid_id, Vector2(width*grid_node_size+grid_node_size, height/2))
	for x in range(width):
		for y in range(height):
			var node = grid_node.instance()
			var nodeId = _get_node_id(x, y)
			grid[nodeId] = node
			aStar.add_point(nodeId, Vector2(x, y))
			if x == 0:
				aStar.connect_points(start_grid_id, nodeId)
			if x == width-1:
				aStar.connect_points(end_grid_id, nodeId)
			if x > 0:
				aStar.connect_points(nodeId, _get_node_id(x-1, y))
			if y > 0:
				aStar.connect_points(nodeId, _get_node_id(x, y-1))
			node.position.x = x*grid_node_size
			node.position.y = y*grid_node_size
			node.x = x
			node.y = y
			add_child(node)
			node.set_size(grid_node_size)
			node.connect("tower_created", self, "_on_tower_created")
			node.connect("tower_removed", self, "_on_tower_removed")
	recalculate_path()

func _get_node_id(x, y):
	return y*width + x

func _on_tower_created(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, true)
	recalculate_path()
	
func _on_tower_removed(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, false)
	recalculate_path()

func recalculate_path():
	var path = aStar.get_id_path(start_grid_id, end_grid_id)
	if path.size() < 2:
		valid_path = false
		return
	valid_path = true
	var curve = $MobPath.get_curve()
	curve.clear_points()
	# Strip the first and last path entry, which aren't in the grid
	for i in range(1, path.size() - 1):
		var grid_id = path[i]
		var x = grid[grid_id].position.x + grid_node_size / 2
		var y = grid[grid_id].position.y + grid_node_size / 2
		curve.add_point(Vector2(x, y))

func _process(delta):
	if valid_path:
		follower.offset += delta * 100
