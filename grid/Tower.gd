extends Node2D

var projectile_instance = preload("res://grid/Projectile.tscn")

var is_active = false
var attack_range = 128
var radius = 0 

func set_radius(r: int):
	self.radius = r
	$ArcDrawer.set_radius(r)
	
func _process(_delta):
	if not is_active:
		return
	var mobs = get_tree().get_nodes_in_group("mob")
	if mobs.size() == 0:
		return
	var nearest = mobs[0]
	var nearest_distance = INF
	for mob in mobs:
		var distance = self.global_position.distance_to(mob.global_position)
		if distance < nearest_distance:
			nearest = mob
			nearest_distance = distance
	if nearest_distance < attack_range:
		attack(nearest)
		

func attack(mob):
	if $AttackTimer.is_stopped():
		var projectile = projectile_instance.instance()
		add_child(projectile)
		projectile.position += Vector2(self.radius, self.radius) / 4
		projectile.direction = self.global_position.direction_to(mob.global_position)
		$AttackTimer.start()

func set_active(active):
	self.is_active = active
	$ArcDrawer.is_active = active
