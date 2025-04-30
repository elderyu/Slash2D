extends Area2D
class_name lever

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func switch():
	if $AnimatedSprite2D.frame == 0:
		$AnimatedSprite2D.frame = 1
		$AudioStreamPlayer2D.play()
