extends Node2D


var mob_instance = preload("res://mob/Mob.tscn")


func _on_MobTimer_timeout():
	var mob = mob_instance.instance()
	$MobPath.add_child(mob)
	$MobTimer.set_wait_time(randf()*2)
