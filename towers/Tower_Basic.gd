extends Node2D



func _ready():
	var r = GridController.grid_node_diameter / 2
	$RectDrawer.width = r*2
	$RectDrawer.height = r*2
