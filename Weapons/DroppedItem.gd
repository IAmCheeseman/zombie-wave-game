extends Area2D

export(Array, String) var items = []

onready var sprite = $Sprite


func _ready():
	rotation_degrees = rand_range(0, 360)

	items.shuffle()
	var item = load(items[0])
	while rand_range(0, 1) > item.rarity:
		items.shuffle()
		item = load(items[0])
	sprite.texture = item.texture
