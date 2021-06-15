extends KinematicBody2D


export var speed = 90

var velocity = Vector2.ZERO
var isDead = false


func _physics_process(delta):
	# Movement
	velocity = Vector2.ZERO
	velocity.y = Input.get_action_strength("S")-Input.get_action_strength("W")
	velocity.x = Input.get_action_strength("D")-Input.get_action_strength("A")
	velocity = velocity.normalized()*speed

	velocity = move_and_slide(velocity)
