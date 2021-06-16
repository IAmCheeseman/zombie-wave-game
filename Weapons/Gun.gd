extends Node2D

onready var weapon:Weapon = preload("res://Weapons/Guns/Pistol.tres") setget setup_weapon

onready var sprite = $Sprite
onready var firerate = $Firerate

var bullet = preload("res://Weapons/Bullet/Bullet.tscn")


func setup_weapon(value):
	weapon = value
	sprite.position.x = weapon.visualOffset
	sprite.texture = weapon.texture
	firerate.wait_time = weapon.firerate


func _ready():
	setup_weapon(weapon)


func _process(delta):
	look_at(get_global_mouse_position())

	var spriteToSelf = sprite.global_position-global_position
	sprite.scale.y = -1 if spriteToSelf.x < 0 else 1
	get_parent().show_behind_parent = true if spriteToSelf.y < 0 else false

	sprite.rotation = lerp_angle(sprite.rotation, 0, 6*delta)

	if firerate.is_stopped() and Input.is_mouse_button_pressed(1):
		shoot()


func shoot():
	var bulletDir = (get_global_mouse_position()-global_position).normalized()
	bulletDir = bulletDir.rotated(deg2rad(rand_range(-weapon.accuracy, weapon.accuracy)))

	var newBullet = bullet.instance()
	newBullet.direction = bulletDir
	newBullet.speed = weapon.bulletSpeed
	newBullet.global_position = global_position+(bulletDir*weapon.bulletOffset)

	get_tree().root.get_node("World").add_child(newBullet)

	sprite.rotation_degrees = -24
	firerate.start()







