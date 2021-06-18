extends KinematicBody2D

enum {CHASE, SPIT}

onready var player:KinematicBody2D = get_node("/root/World/Player")
onready var anim = $AnimationPlayer
onready var spitTimer = $SpitTimer
onready var sprite = $ScaleHelper/Sprite
onready var hurtAnim = $Hurt

export var speed = 80
export var damage = 5

var vel = Vector2.ZERO
var health = 15
var state = CHASE

var bullet = preload("res://Weapons/Bullet/EnemyBullet.tscn")


func _process(delta):
	if !has_node("/root/World/Player"):
		set_process(false)
		anim.play("Idle")
		return

	vel = Vector2.ZERO

	# Flipping the sprite based on player postion
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


func spit():
	var bulletDir = global_position.direction_to(player.global_position)

	var newBullet = bullet.instance()
	newBullet.direction = bulletDir
	newBullet.speed = 100
	newBullet.time = 5
	newBullet.damage = damage
	newBullet.global_position = (global_position+(bulletDir*12))-Vector2(0, 5)

	get_tree().root.get_node("World").add_child(newBullet)


func deal_damage(amount:float, dir:Vector2):
	health -= amount
	position += dir
	hurtAnim.play("Hurt")
	if health <= 0:
		queue_free()








