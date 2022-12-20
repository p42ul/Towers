extends Node

var width = 12
var height = 6

var grid = []

export(PackedScene) var grid_node

signal create_tower(x, y)
signal remove_tower(x, y)

func _input(event):
	if Input.is_action_just_pressed("grid_click"):
		var mouse_position = get_viewport().get_mouse_position()
		print("CLICK!" + str(mouse_position))

func _ready():
	grid.resize(width)
	grid.fill([])
	for x in range(width):
		grid[x].resize(height)
		for y in range(height):
			var node = grid_node.instance()
			grid[x][y] = node
			node.position.x = x*40
			node.position.y = y*40
			node.x = x
			node.y = y
			add_child(node)
