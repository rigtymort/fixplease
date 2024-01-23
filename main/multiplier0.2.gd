extends Node2D



func _on_area_2d_area_entered(area):
	# Get a list of all objects overlapping with the 2D area
	var overlapping_objects = area.get_overlapping_bodies()
	
	# Iterate through the list and delete each object
	for obj in overlapping_objects:
		obj.queue_free()
		print("Deleting Object:", obj.name)



