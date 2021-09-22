extends Node2D

var droppedWeapon:PackedScene = preload("res://Weapons/DroppedItem.tscn")
var currentWeaponCount:int = 0


export var gunSpawnRect:Rect2


func add_new_weapon() -> void:
	if currentWeaponCount > 3:
		return
	var limits := gunSpawnRect.end
	var padding := 16

	var newWeapon:Node2D = droppedWeapon.instance()
	newWeapon.position.x = rand_range(gunSpawnRect.position.x-padding, gunSpawnRect.end.x-padding)
	newWeapon.position.y = rand_range(gunSpawnRect.position.y-padding, gunSpawnRect.end.y-padding)
	add_child(newWeapon)
	
	newWeapon.connect("pickedUp", self, "_on_weapon_picked_up")
	currentWeaponCount += 1


func _on_weapon_picked_up() -> void:
	currentWeaponCount -= 1
