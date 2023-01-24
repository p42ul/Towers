extends Node2D

var width = 24
var height = 12

var grid_node_diameter = 32

var start_grid_id = width*height + 1
var end_grid_id = width*height + 2

var grid = []
var aStar = AStar2D.new()

var grid_node = load("res://grid/GridNode.tscn")

signal path_changed(path)

func _draw():
	for x in range(width+1):
		for y in range(height+1):
			draw_circle(Vector2(x*grid_node_diameter, y*grid_node_diameter),
				1.0, Color.white)

func _ready():
	aStar.reserve_space(width*height+2)
	grid.resize(width*height)
	aStar.add_point(start_grid_id, Vector2(-grid_node_diameter, height/2))
	aStar.add_point(end_grid_id, Vector2(width*grid_node_diameter+grid_node_diameter, height/2))
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
			node.position.x = x*grid_node_diameter
			node.position.y = y*grid_node_diameter
			node.x = x
			node.y = y
			add_child(node)
			node.set_radius(grid_node_diameter / 2)

func _get_node_id(x, y):
	return y*width + x

func try_create_tower(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, true)
	var path = self.recalculate_path()
	if path.size() > 0:
		emit_signal("path_changed", path)
		return true
	aStar.set_point_disabled(nodeId, false)
	return false
	
func remove_tower(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, false)
	var path = self.recalculate_path()
	emit_signal("path_changed", path)

# Returns empty list if no path can be found, a list of Vector2 otherwise.
func recalculate_path():
	var result = aStar.get_id_path(start_grid_id, end_grid_id)
	var path = []
	if result.size() < 2:
		return path
	# Strip the first and last pathfinding entries, which aren't in the grid
	for i in range(1, result.size() - 1):
		var grid_id = result[i]
		var x = grid[grid_id].position.x + grid_node_diameter / 2
		var y = grid[grid_id].position.y + grid_node_diameter / 2
		path.append(Vector2(x, y))
	return path


