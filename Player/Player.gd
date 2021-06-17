extends KinematicBody2D

onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var gun = $Gun

export var speed = 90

var velocity = Vector2.ZERO
var isDead = false
var secondaryWeapon:Weapon


func _ready():
	randomize()


func _physics_process(delta):
	velocity = Vector2.ZERO
	movement()
	face_mouse()

	velocity = move_and_slide(velocity*delta)


func movement():
	# Movement
	velocity.y = Input.get_action_strength("S")-Input.get_action_strength("W")
	velocity.x = Input.get_action_strength("D")-Input.get_action_strength("A")
	velocity = velocity.normalized()*speed

	if velocity.is_equal_approx(Vector2.ZERO): anim.play("Idle")
	else: anim.play("Run")


func face_mouse():
	var mousePos = get_local_mouse_position()

	if mousePos.x > 0: sprite.scale.x = -1
	else: sprite.scale.x = 1


func set_weapon(weapon:Weapon):
	gun.weapon = weapon


func _input(event):
	if event.is_action_pressed("swap_weapons") and secondaryWeapon:
		var currentWeapon = gun.weapon.duplicate()
		gun.weapon = secondaryWeapon.duplicate()
		secondaryWeapon = currentWeapon
