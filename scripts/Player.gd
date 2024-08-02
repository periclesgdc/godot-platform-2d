extends KinematicBody2D


export var grav: float
export var vel: float
export var jump_speed: float
export var lifes: int

var move = Vector2.ZERO
var dir = Vector2.DOWN
var jumping = false

signal died


func _ready():
	jump_speed *= -1

func _physics_process(delta):
	handle_anim()
	
	move.y += grav * delta
	
	if jumping:
		move.y = lerp(move.y, jump_speed, 1)
		if move.y == jump_speed:
			jumping = false
	
	move.x = dir.x * vel
	
	if is_on_floor() and Input.is_action_pressed("ui_up"):
		jumping = true
	
	move = move_and_slide(move, Vector2.UP)

func _input(event):
	if event.is_action_pressed("ui_right"):
		dir.x = 1
		$Animations.flip_h = false
	elif event.is_action_pressed("ui_left"):
		dir.x = -1
		$Animations.flip_h = true
	elif event.is_action_released("ui_right") or event.is_action_released("ui_left"):
		dir.x = 0

func handle_anim():
	if dir.x == 0 or !is_on_floor():
		$Animations.play("idle")
	else:
		$Animations.play("walk")

func bounce():
	jumping = true

func hit():
	lifes -= 1

	if lifes == 0:
		emit_signal("died")
