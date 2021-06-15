extends KinematicBody2D


onready var sprite = $Sprite
onready var anim = $AnimationPlayer

export var speed = 90

var velocity = Vector2.ZERO
var isDead = false


func _physics_process(delta):
	movement()
	face_mouse()

	velocity = move_and_slide(velocity*delta)


func movement():
	# Movement
	velocity = Vector2.ZERO
	velocity.y = Input.get_action_strength("S")-Input.get_action_strength("W")
	velocity.x = Input.get_action_strength("D")-Input.get_action_strength("A")
	velocity = velocity.normalized()*speed

	if velocity.is_equal_approx(Vector2.ZERO): anim.play("Idle")
	else: anim.play("Run")


func face_mouse():
	var mousePos = get_local_mouse_position()
	var spriteScale = -round(mousePos.normalized().x)

	sprite.scale.x = spriteScale if spriteScale != 0 else sprite.scale.x
