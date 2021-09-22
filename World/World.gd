extends YSort

onready var spawnManager = $SpawnManagment
onready var path = $Path


func _ready() -> void:
	spawnManager.gunSpawnRect = path.get_used_rect()
#	spawnManager.gunSpawnRect.position *= path.cell_size
	spawnManager.gunSpawnRect.end *= path.cell_size
