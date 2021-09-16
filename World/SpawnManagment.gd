extends Node2D

var droppedWeapon:PackedScene = preload("res://Weapons/DroppedItem.tscn")


func add_new_weapon() -> void:
	var limits := get_viewport_rect().end
	var padding := 16

	var newWeapon:Node2D = droppedWeapon.instance()
	newWeapon.position.x = rand_range(padding, limits.x-padding)
	newWeapon.position.y = rand_range(padding, limits.y-padding)
	add_child(newWeapon)
	
