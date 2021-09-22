extends KinematicBody2D

enum {MOVE, SLAM}

export var speed:int = 80
export var damage:int = 1
export var bulletCount = 8

onready var player = get_node("/root/World/Player")
onready var sprite = $ScaleHelper/Sprite
onready var slamTimer = $SlamTimer
onready var anim = $AnimationPlayer
onready var hurtAnim = $Hurt
onready var softCollision = $SoftCollision


var state:int = MOVE
var health:float = 35
var vel:Vector2 = Vector2.ZERO
var targetPosition = Vector2.ZERO

var bullet = preload("res://Weapons/Bullet/EnemyBullet.tscn")

signal death


func _ready() -> void:
	get_new_target()


func _physics_process(delta: float) -> void:
	if !has_node("/root/World/Player"):
		set_process(false)
		return

	vel = Vector2.ZERO

	# Flipping the sprite based on player postion
	sprite.scale.x = 1 if player.global_position.x < global_position.x else -1
	
	match state:
		MOVE:
			anim.play("Run")
			vel = global_position.direction_to(targetPosition)*delta
			if global_position.distance_to(targetPosition) < 5:
				get_new_target()
		SLAM:
			anim.play("Smash")
	position += softCollision.get_push_dir()
			
	vel = move_and_slide(vel*speed)


func slam():
	var rotationDiff = 360/bulletCount
	var currRot = 0
	for i in bulletCount:
		var dir = Vector2.RIGHT.rotated(deg2rad(currRot))
		currRot += rotationDiff
		
		var newBullet = bullet.instance()
		newBullet.damage = damage
		newBullet.direction = dir
		newBullet.speed = 100
		newBullet.time = 5
		newBullet.damage = damage
		newBullet.global_position = (global_position+(dir*12))-Vector2(0, 5)

		get_tree().root.get_node("World").add_child(newBullet)


func deal_damage(amount:float, dir:Vector2):
	health -= amount
	position += dir
	hurtAnim.play("Hurt")
	if health <= 0:
		emit_signal("death", self)
		GameManager.score += 300
		queue_free()


func get_new_target():
	targetPosition = global_position+Vector2.RIGHT.rotated(rand_range(0, 360))*rand_range(16, 48)


func _on_slam_timer_timeout() -> void:
	state = SLAM
	slamTimer.start(rand_range(4, 6))


func _on_move_timer_timeout() -> void:
	get_new_target()
