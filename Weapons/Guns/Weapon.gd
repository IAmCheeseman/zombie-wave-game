extends Resource
class_name Weapon

export(float, 0, 1) var rarity = .5
export var damage = 5
export var magazineSize = 8
export var firerate = .4
export var multishot = 1
export var spread = 2
export var bulletSpeed = 320
export var accuracy = 12.0
export var lifetime = .225
export var bulletOffset = 16
export var visualOffset = 12
export var texture:StreamTexture
export var goldTexture:StreamTexture

var isGold = false
