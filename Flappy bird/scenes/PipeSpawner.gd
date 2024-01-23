extends Node

class_name PipeSpawner

signal bird_crashed
signal point_scored

var pipe_pair_scene = preload("res://Flappy bird/scenes/pipe_pair.tscn")

@onready var spawn_timer = $SpawnTimer
@onready var hit = $"../SFX/hit"
@onready var bird_hit = 0

var pipe_speed = -150



# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_timer.timeout.connect(spawn_pipe)
	
	
	
func start_spawning_pipes():
	spawn_timer.start()
		
func spawn_pipe():
	var pipe = pipe_pair_scene.instantiate() as PipePair
	add_child(pipe)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	pipe.position.x = viewport_rect.end.x
	
	var half_height = viewport_rect.size.y / 2
	pipe.position.y = randf_range(viewport_rect.size.y * 0.15 - half_height, viewport_rect.size.y * 0.65 - half_height)
	
	pipe.bird_enterd.connect(on_bird_entered)
	pipe.point_scored.connect(on_point_scored)
	pipe.set_speed(pipe_speed)
	
func on_bird_entered():
	if bird_hit == 0:
		hit.play()
		bird_hit += 1
	bird_crashed.emit()
	stop()
	
func stop():
	spawn_timer.stop()
	for pipe in get_children().filter(func (child): return child is PipePair):
		(pipe as PipePair).speed = 0 
	
func on_point_scored():
	point_scored.emit()
