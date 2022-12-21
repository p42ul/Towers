extends Node

var width = 12
var height = 6

var grid_node_size = 40

var grid = []

export(PackedScene) var grid_node

signal create_tower(x, y)
signal remove_tower(x, y)

func _ready():
	grid.resize(width)
	grid.fill([])
	for x in range(width):
		grid[x].resize(height)
		for y in range(height):
			var node = grid_node.instance()
			grid[x][y] = node
			node.position.x = x*grid_node_size
			node.position.y = y*grid_node_size
			add_child(node)
			node.set_size(grid_node_size)
