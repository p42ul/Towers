extends Node2D

func _ready():
	BuildTools.connect("tool_changed", Callable(self, "_on_tool_changed"))

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("select"):
		BuildTools.set_tool(BuildTools.BUILD_SHOOT)

func _on_tool_changed(new_tool):
	if new_tool == BuildTools.BUILD_SHOOT:
		$ArcDrawer.filled = true
	else:
		$ArcDrawer.filled = false
