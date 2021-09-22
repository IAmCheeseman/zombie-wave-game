extends Control

onready var hpBar = $HealthBar
onready var hpBarUnder = $HealthBar/BarUnder

onready var ammoBar = $AmmoBar
onready var ammoBarLabel = $AmmoBar/Label

onready var waveLabel = $HBoxContainer/Label
onready var scoreLabel = $HBoxContainer/Score


func _on_hp_changed(hp, mhp) -> void:
	yield(get_tree(), "idle_frame")
	hpBar.rect_size.x = (hp)*hpBar.texture.get_width()
	hpBarUnder.rect_size.x = mhp*hpBar.texture.get_width()


func _on_weapon_shoot(weap) -> void:
	yield(get_tree(), "idle_frame")
	ammoBarLabel.text = ":%s/%s" % [weap.ammoLeft, weap.weapon.magazineSize]


func _process(delta: float) -> void:
	waveLabel.text = "Wave:%s" % GameManager.wave
	scoreLabel.text = "Score:\n%s" % GameManager.score

