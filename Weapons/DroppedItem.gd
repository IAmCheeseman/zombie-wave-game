extends Area2D

export(Array, String) var items = []

onready var sprite = $Sprite

var item

signal pickedUp


func _ready():
	sprite.rotation_degrees = rand_range(0, 360)

	items.shuffle()
	item = load(items[0]).duplicate()
	while rand_range(0, 1) > item.rarity:
		items.shuffle()
		item = load(items[0]).duplicate()
	
	if rand_range(0, 1) < .20:
		sprite.texture = item.goldTexture
		item.isGold = true
	else:
		sprite.texture = item.texture


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.set_weapon(item)
		emit_signal("pickedUp")
		queue_free()

