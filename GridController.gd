extends Node2D

var width = 20
var height = 10

var grid_node_size = 40

var grid = []
var aStar

export(PackedScene) var grid_node

func _ready():
	aStar = AStar2D.new()
	aStar.reserve_space(width*height)
	grid.resize(width*height)
	for x in range(width):
		for y in range(height):
			var node = grid_node.instance()
			var nodeId = _get_node_id(x, y)
			grid[nodeId] = node
			aStar.add_point(nodeId, Vector2(x, y))
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
			

func _get_node_id(x, y):
	return y*width + x

func _on_tower_created(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, true)
	
func _on_tower_removed(x, y):
	var nodeId = _get_node_id(x, y)
	aStar.set_point_disabled(nodeId, false)

func _on_find_path():
	var path = aStar.get_id_path(0, width*height-1)
	if path.size() < 2:
		print("couldn't find path")
		return
	var curve = $MobPath.get_curve()
	curve.clear_points()
	for grid_id in path:
		curve.add_point(grid[grid_id].position)
		grid[grid_id].flash_color(Color.aquamarine)

func _process(delta):
	var follower = $MobPath/MobPathFollower
	follower.unit_offset += delta / 10
