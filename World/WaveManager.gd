extends Node2D

var enemiesCount = 5


func spawn_enemies():
	for i in enemiesCount:
		var newZombie = load("res://Enemies/Zombie/Zombie.tscn").instance()
		var limits = get_viewport_rect()

		newZombie.position = Vector2(rand_range(0, limits.end.x), rand_range(0, limits.end.y))

