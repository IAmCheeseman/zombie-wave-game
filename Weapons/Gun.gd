extends Node2D

onready var weapon:Weapon = preload("res://Weapons/Guns/Pistol.tres") setget setup_weapon

onready var sprite = $Sprite
onready var firerate = $Firerate

var bullet = preload("res://Weapons/Bullet/Bullet.tscn")
var ammoLeft = 0

signal shot

func setup_weapon(value):
	weapon = value
	sprite.position.x = weapon.visualOffset
	if weapon.isGold:
		sprite.texture = weapon.goldTexture
		weapon.magazineSize *= 1.5
		weapon.magazineSize = ceil(weapon.magazineSize)
	else: sprite.texture = weapon.texture
	firerate.wait_time = weapon.firerate
	ammoLeft = weapon.magazineSize
	emit_signal("shot", self)


func _ready():
	setup_weapon(weapon)


func _process(delta):
	look_at(get_global_mouse_position())

	var spriteToSelf = sprite.global_position-global_position
	sprite.scale.y = -1 if spriteToSelf.x < 0 else 1
	show_behind_parent = true if spriteToSelf.y < 0 else false

	sprite.rotation = lerp_angle(sprite.rotation, 0, 6*delta)

	if firerate.is_stopped() and Input.is_mouse_button_pressed(1) and ammoLeft > 0:
		shoot()


func shoot():
	for i in weapon.multishot:
		var bulletDir = (get_global_mouse_position()-global_position).normalized()
		var spread = deg2rad(weapon.spread*i-(weapon.spread*(weapon.multishot-1)/2))
		bulletDir = bulletDir.rotated(deg2rad(rand_range(-weapon.accuracy, weapon.accuracy))+spread)

# warning-ignore:incompatible_ternary
		var mod = 1.5 if weapon.isGold else 1
# warning-ignore:incompatible_ternary
		var dMod = .75 if weapon.isGold else 1

		var newBullet = bullet.instance()
		newBullet.direction = bulletDir
		newBullet.speed = weapon.bulletSpeed
		newBullet.time = weapon.lifetime*mod
		newBullet.damage = weapon.damage*mod
		newBullet.global_position = global_position+(bulletDir*weapon.bulletOffset)

		get_tree().root.get_node("World").add_child(newBullet)

		sprite.rotation_degrees = 24*-sprite.scale.y
		firerate.start(weapon.firerate*dMod)
	ammoLeft -= 1
	emit_signal("shot", self)
	if ammoLeft <= 0:
		sprite.texture = null







