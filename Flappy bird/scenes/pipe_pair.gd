extends Node2D

class_name  PipePair

signal bird_enterd
signal point_scored


var speed = 0

func set_speed(new_speed):
	speed = new_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed * delta
	
func _on_body_entered(body):
	bird_enterd.emit()
	
func _on_point_scored(body):
	point_scored.emit()
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
