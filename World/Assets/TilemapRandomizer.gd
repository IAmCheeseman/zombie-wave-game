tool
extends TileMap

export var randomizeIt:bool = false setget set_randomize


func set_randomize(_val:bool) -> void:
	var usedTiles:PoolVector2Array = get_used_cells()
	var tileIDs:PoolIntArray = tile_set.get_tiles_ids()
	
	for i in usedTiles:
		var id = tileIDs[rand_range(0, tileIDs.size())]
		set_cellv(i, id, Utils.random_bool())
		tile_set.tile_set_texture_offset(i, Vector2(-4, -4))
	


func get_tile_count():
	var t = tile_set.get_tiles_ids()
	var largestID:int = 0
	for i in t:
		if i > largestID:
			largestID = i
	return largestID
