extends KinematicBody2D

enum {CHASE, SPIT}

onready var player:KinematicBody2D = get_node("/root/World/Player")
onready var anim = $AnimationPlayer
onready var spitTimer = $SpitTimer
onready var sprite = $ScaleHelper/Sprite

export var speed = 80

var vel = Vector2.ZERO
var health = 15
var state = CHASE

var bullet = preload("res://Weapons/Bullet/EnemyBullet.tscn")


func _process(delta):
	vel = Vector2.ZERO

	sprite.scale.x = 1 if player.global_position.x < global_position.x else -1

	match state:
		CHASE:
			anim.play("Run")
			vel = global_position.direction_to(player.global_position)*delta
		SPIT:
			anim.play("Spit")

	vel = move_and_slide(vel*speed)


func _on_spit_timer_timeout():
	state = SPIT
	spitTimer.start(rand_range(2, 4))


func _on_spit_over(): state = CHASE
