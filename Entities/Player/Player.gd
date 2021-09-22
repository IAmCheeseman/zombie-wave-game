extends KinematicBody2D

onready var sprite = $Sprite
onready var anim = $AnimationPlayer
onready var gun = $Gun
onready var iframes = $IFrames
onready var hurtAnim = $Hurt

export var speed = 90

var velocity = Vector2.ZERO
var isDead = false
var secondaryWeapon:Weapon
var maxHealth = 5
var health = 5

signal hurt(health, maxHealth)


func _ready() -> void:
	randomize()
	emit_signal("hurt", health, maxHealth)


func _physics_process(delta) -> void:
	velocity = Vector2.ZERO
	movement()
	face_mouse()

	velocity = move_and_slide(velocity*delta)


func movement() -> void:
	# Movement
	velocity.y = Input.get_action_strength("S")-Input.get_action_strength("W")
	velocity.x = Input.get_action_strength("D")-Input.get_action_strength("A")
	velocity = velocity.normalized()*speed

	if velocity.is_equal_approx(Vector2.ZERO): anim.play("Idle")
	else: anim.play("Run")


func face_mouse() -> void:
	var mousePos = get_local_mouse_position()

	if mousePos.x > 0: sprite.scale.x = -1
	else: sprite.scale.x = 1


func set_weapon(weapon:Weapon) -> void:
	gun.weapon = weapon


func _input(event) -> void:
	if event.is_action_pressed("swap_weapons") and secondaryWeapon:
		var currentWeapon = gun.weapon.duplicate()
		gun.weapon = secondaryWeapon.duplicate()
		secondaryWeapon = currentWeapon


func deal_damage(amount:float, dir:Vector2) -> void:
	if iframes.is_stopped():
		# Screenshake
		var sm = ScreenshakeManager.new(self)
		sm.start_ss(2, 5, .05, .05)
		sm.queue_free()
		
		emit_signal("hurt", health-1, maxHealth)
		
		health -= amount
		position += dir
		hurtAnim.play("Hurt")
		iframes.start()
		if health <= 0:
			hide()
			speed = 0






