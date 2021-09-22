extends KinematicBody2D

enum {CHASE, SPIT}

onready var player:KinematicBody2D = get_node("/root/World/Player")
onready var anim = $AnimationPlayer
onready var spitTimer = $SpitTimer
onready var sprite = $ScaleHelper/Sprite
onready var hurtAnim = $Hurt
onready var softCollision = $SoftCollision

export var speed = 80
export var damage = 1

var vel = Vector2.ZERO
var health = 15
var state = CHASE
var targetPosition = Vector2.ZERO

var bullet = preload("res://Weapons/Bullet/EnemyBullet.tscn")

signal death


func _ready():
	get_new_target()


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
			vel = global_position.direction_to(targetPosition)*delta
			if global_position.distance_to(targetPosition) < 5:
				get_new_target()
		SPIT:
			anim.play("Spit")
	position += softCollision.get_push_dir()

	vel = move_and_slide(vel*speed)


func get_new_target():
	targetPosition = global_position+Vector2.RIGHT.rotated(rand_range(0, 360))*rand_range(16, 48)


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
		emit_signal("death", self)
		GameManager.score += 100
		queue_free()


func _on_chase_timer_timeout():
	get_new_target()
