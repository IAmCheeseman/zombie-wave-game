extends Area2D

export var strength = 5

func get_push_dir():
	var overlappingAreas = get_overlapping_areas()
	var pushDir = Vector2.ZERO
	for area in overlappingAreas:
		pushDir += -global_position.direction_to(area.global_position)*strength
	return pushDir
