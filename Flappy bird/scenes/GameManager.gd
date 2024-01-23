extends Node

@onready var bird = $"../Bird" as Bird
@onready var ground = $"../Ground" as Ground
@onready var pipe_spawner = $"../PipeSpawner" as PipeSpawner
@onready var fade = $"../fade" as Fade
@onready var ui = $"../UI" as UI
@onready var point = $"../SFX/Point"
@onready var woosh = $"../SFX/woosh"
@onready var start = $"../Start"
@onready var background_music = $"../SFX/BackgroundMusic"


var path_to_file = "user://sava.data"

var points = 0
var high_score 
var Start_woosh = 0 

func _ready():
	load_game()
	bird.game_started.connect(on_game_started)
	ground.bird_crashed.connect(end_game)
	pipe_spawner.bird_crashed.connect(end_game)
	pipe_spawner.point_scored.connect(on_point_scored)
	background_music.play()
	
func  _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func on_game_started():
	pipe_spawner.start_spawning_pipes()
	if Start_woosh == 0:
		woosh.play()
	
func end_game():
	if fade != null:
		fade.play()
	ground.stop()
	bird.kill()
	pipe_spawner.stop()
	save_game() 
	ui.on_game_over(points, high_score)
	
	
func on_point_scored():
	points += 1
	if points > high_score:
		high_score = points
	ui.update_points(points)
	point.play()
	
func save_game():
	var save_file = FileAccess.open(path_to_file, FileAccess.WRITE)
	save_file.store_32(high_score)

func load_game():
	var save_file = FileAccess.open(path_to_file, FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
		save_game()
	


