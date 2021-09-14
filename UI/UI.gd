extends Control

onready var hpBar = $HealthBar
onready var hpBarUnder = $HealthBar/BarUnder


func _on_hp_changed(hp, mhp):
	yield(get_tree(), "idle_frame")
	hpBar.rect_size.x = (hp)*hpBar.texture.get_width()
	hpBarUnder.rect_size.x = mhp*hpBar.texture.get_width()
	
