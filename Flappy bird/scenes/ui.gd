extends CanvasLayer

class_name UI

@onready var points_label = $MarginContainer/PointsLabel
@onready var game_over_box = $MarginContainer/GameOverBox
@onready var score = $MarginContainer/GameOverBox/Panel/Score
@onready var HighScore = $MarginContainer/GameOverBox/Panel/HighScore


func _ready():
	points_label.text = "%d" % 0
	
func update_points(points :int):
	points_label.text = "%d" % points
	
func on_game_over(points: int, high_score: int):
	game_over_box.visible = true
	set_score(points)
	set_high_score(high_score)
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://mainMenu/mainMenu.tscn")
	
func set_high_score(high_score):
	HighScore.text = "High-score: " + str(high_score)

func set_score(points):
	score.text = "Score: " + str(points)
	
	
