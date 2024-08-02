extends KinematicBody2D


export var speed: float
export var grav: float

var vel = Vector2.ZERO
var dir = Vector2.RIGHT


func _physics_process(delta):
	vel.y += grav * delta
	vel.x = dir.x * speed
	
	vel = move_and_slide(vel, Vector2.UP)
	
	if $Detector.is_colliding():
		var collider = $Detector.get_collider()
		if collider.has_method("hit"):
			collider.call("hit")

	if is_on_wall() or $Detector.is_colliding() or !$FootDetector.is_colliding():
		dir.x *= -1
		$Animation.flip_h = !$Animation.flip_h
		$Detector.rotation_degrees *= -1
		$FootDetector.position.x *= -1


func _on_Hitbox_body_entered(body):
	if body.is_in_group("player"):
		body.bounce()
		queue_free()
