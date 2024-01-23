extends Node2D

# Declare member variables here. Examples:
var spawn_object_scene : PackedScene = preload("res://main/plinkoBall.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Check for mouse click
	if Input.is_action_just_pressed("mouse_left"):
		spawn_object()

# Function to spawn the object
func spawn_object():
	# Create a new instance of the spawned object
	var new_object : Node2D = spawn_object_scene.instantiate()

	# Set the scale of the new object (you can customize this as needed)

	# Add the new object to the scene
	add_child(new_object)

	# Set the position of the new object randomly within a radius of 20 around the launcher's position
	var angle = randf() * 2 * PI  # Random angle in radians between 0 and 2*PI
	var radius = 80
	var spawn_position = Vector2(cos(angle), sin(angle)) * radius
	new_object.position = position + spawn_position
	
	# Print out the spawn position for debugging
	print("Spawn Position:", position + spawn_position)
