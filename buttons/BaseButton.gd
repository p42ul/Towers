extends Node2D

func _ready():
	BuildTools.connect("tool_changed", Callable(self, "_on_tool_changed"))
	# This is the default tool, so start with it filled
	$RectDrawer.filled = true

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("select"):
		BuildTools.set_tool(BuildTools.BUILD_BASIC)

func _on_tool_changed(new_tool):
	if new_tool == BuildTools.BUILD_BASIC:
		$RectDrawer.filled = true
	else:
		$RectDrawer.filled = false
