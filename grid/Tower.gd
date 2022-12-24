extends AnimatedSprite

var projectile_instance = preload("res://grid/Projectile.tscn")

var active = false
var attack_range = 128

func _ready():
	self.hide()

func _process(delta):
	if not active:
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
		projectile.direction = self.global_position.direction_to(mob.global_position)
		print("attacking")
		$AttackTimer.start()

func set_active(active):
	if active:
		self.show()
	else:
		self.hide()
	self.active = active
