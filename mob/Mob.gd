extends PathFollow2D

@export var speed = 100
@export var health = 3
var radius = 0

signal reached_end

func _ready():
	self.radius = GridController.grid_node_diameter / 2.0
	$Area2D/CollisionShape2D.shape.radius = self.radius

func _process(delta):
	self.progress += delta * speed
	if self.progress_ratio == 1.0:
		emit_signal("reached_end")
		self.queue_free()

func _on_projectile_area_entered(area):
	if not area.is_in_group("projectile"):
		return
	area.queue_free()
	self.health -= area.damage
	if self.health <= 0:
		self.queue_free()

func _draw():
	draw_circle(Vector2.ZERO, self.radius, Color.RED)
