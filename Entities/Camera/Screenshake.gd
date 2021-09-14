extends Node


onready var timer = $Timer
onready var tween = $Tween
onready var camera = get_parent()


var pri := -1
var stren := 5.0
var freq := .05
var time := .2
var dir := Vector2.ZERO


func _ready():
	assert(camera is Camera2D)
	


func start_shake(pri_:int=0, stren_:float=5, freq_:float=.05, time_:float=.2, dir_:Vector2=Vector2.ZERO):
	if pri_ <= pri:
		return
	
	pri = pri_
	stren = stren_
	freq = freq_
	timer.wait_time = time_
	
	timer.start()
	tween.stop_all()
	shake()


func shake():
	var target := Vector2.RIGHT.rotated(rand_range(0, 360))*stren
	tween.interpolate_property(camera, "offset", camera.offset, target, freq)
	tween.start()


func _on_tween_all_completed():
	if timer.is_stopped():
		tween.interpolate_property(camera, "offset", camera.offset, Vector2.ZERO, freq)
		tween.start()
		reset()
		return
	shake()


func reset():
	pri = 0
