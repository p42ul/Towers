extends Node2D

var shooter_instance = preload("res://towers/Tower_Shooter.tscn")
var basic_instance = preload("res://towers/Tower_Basic.tscn")

enum {BUILD_BASIC, BUILD_SHOOT}

signal tool_changed(new_tool)

var selected_tool = BUILD_BASIC
var tower = basic_instance


func set_tool(new_tool):
	self.selected_tool = new_tool
	if new_tool == BUILD_BASIC:
		self.tower = basic_instance
	elif new_tool == BUILD_SHOOT:
		self.tower = shooter_instance
	emit_signal("tool_changed", new_tool)
