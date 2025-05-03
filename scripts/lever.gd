extends Area2D
class_name lever

func switch():
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.frame = 1
		$AudioStreamPlayer2D.play()
