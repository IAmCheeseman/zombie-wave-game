extends Node2D


export var enemyHolderP:NodePath
onready var enemyHolder:Node2D = get_node(enemyHolderP)


var enemyCount = 5
var currentAliveEnemies = 0


func _ready() -> void:
	spawn_enemies()


func spawn_enemies() -> void:
	for i in enemyCount:
		var newZombie = preload("res://Entities/Enemies/Zombie/Zombie.tscn").instance()
		var limits = get_viewport_rect()
		newZombie.connect("death", self, "_on_enemy_death")
		newZombie.position = Vector2(rand_range(0, limits.end.x), rand_range(0, limits.end.y))
		enemyHolder.call_deferred("add_child", newZombie)
	currentAliveEnemies = enemyCount
	enemyCount *= 1.10


func _on_enemy_death(_enemy:Node2D) -> void:
	currentAliveEnemies -= 1
	if currentAliveEnemies <= 0:
		spawn_enemies()
		GameManager.wave += 1
