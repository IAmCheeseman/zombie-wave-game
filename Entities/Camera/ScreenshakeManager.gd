extends Node
class_name ScreenshakeManager


func _init(pri_:int=0, stren_:float=5, freq_:float=.05, time_:float=.2, dir_:Vector2=Vector2.ZERO):
	get_tree().call_group("Screenshake", "start_shake", pri_, stren_, freq_, time_, dir_)
	queue_free()
