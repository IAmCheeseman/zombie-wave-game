extends Area2D
class_name Bullet


onready var speedTween = $SpeedTween
onready var scaleTween = $ScaleTween
onready var timer = $Timer

var direction:Vector2
var speed:float
var time:float


func _ready():
	timer.wait_time = time
	timer.start()
	look_at(global_position+direction)


func _process(delta):
	global_position += (direction*speed)*delta


func die_out():
	monitoring = false
	modulate = Color(.5, .5, .5)
	speedTween.interpolate_property(self, "speed", speed, 0, .2)
	speedTween.start()
	scaleTween.interpolate_property(self, "scale", scale, Vector2.ZERO, .1)
	scaleTween.start()


func _on_Tween_tween_all_completed():
	queue_free()


