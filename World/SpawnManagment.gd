extends Node2D

var droppedWeapon = preload("res://Weapons/DroppedItem.tscn")

func add_new_weapon():
	var limits = get_viewport_rect().end
	var padding = 16

	var newWeapon = droppedWeapon.instance()
	newWeapon.position.x = rand_range(padding, limits.x-padding)
	newWeapon.position.y = rand_range(padding, limits.y-padding)
	add_child(newWeapon)
