extends AnimatedSprite

var active = false
var attack_range = 128

func _ready():
	self.hide()

func _process(delta):
	if not active:
		return
	var mobs = get_tree().get_nodes_in_group("mob")
	var nearest = mobs[0]
	var nearest_distance = INF
	for mob in mobs:
		var distance = self.position.distance_to(mob.position)
		if distance < self.position.distance_to(nearest.position):
			nearest = mob
			nearest_distance = distance
	if nearest_distance < attack_range:
		attack(nearest)
		
func attack(mob):
	print("attack()")
	if $AttackTimer.is_stopped():
		print("attacking!")
		mob.queue_free()
		$AttackTimer.start()

func set_active(active):
	if active:
		self.show()
	else:
		self.hide()
	self.active = active
