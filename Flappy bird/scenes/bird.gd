extends CharacterBody2D

class_name Bird

signal game_started

@export var gravity = 900.0
@export var jump_force = -300
@export var rotation_speed = 2

@onready var animation_player = $AnimationPlayer
@onready var wing = $"../SFX/Wing"



var max_speed = 200
var is_started = false
var should_process_input = true

func _ready():
	velocity = Vector2.ZERO
	animation_player.play("Idle")

func _physics_process(delta):
	if Input.is_action_just_pressed("jump") && should_process_input:
		if !is_started:
			game_started.emit()
			animation_player.play("flap_wings")
			is_started = true
		jump()
	
	if !is_started:
		return
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()
		
func jump():
	velocity.y = jump_force
	rotation = deg_to_rad(-30)
	wing.play()
	
func rotate_bird():
	# rotate downward when falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotation_speed * rad_to_deg(1)
	# rotate upwhard when rising
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotation_speed * rad_to_deg(1)

func kill():
	should_process_input = false
	
	
func stop():
	animation_player.stop()
	gravity = 0
	velocity = Vector2.ZERO
	
	
