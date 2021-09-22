extends Reference
class_name Utils


static func random_bool() -> bool:
	return true if rand_range(0, 1) < .5 else false
