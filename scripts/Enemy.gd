class_name Enemy extends Entity

@export var Target = CharacterBody2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var ray_cast = $RayCast2D
var detected = false
var player_in_area = false
var facingRight = true

func _process(delta: float) -> void:
	if player_in_area:
		aim()
		if ray_cast.get_collider() == Target:
			detected = true
		
	else:
		print("not in area")
	if !nav_agent.is_target_reached():
		var dir = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		change_side(dir)
		move_and_slide()
	
func makePath():
	if detected:
		nav_agent.target_position = Target.global_position
	
func change_side(dir):
	if velocity.x < 0  and facingRight:
		animationSprite.flip_h = true
		facingRight = false
	elif velocity.x > 0 and !facingRight:
		animationSprite.flip_h = false
		facingRight = true


func _on_timer_timeout():
	makePath()

func aim():
	ray_cast.target_position = to_local(Target.global_position) - ray_cast.position

func _on_outer_detection_area_body_exited(body: Node2D) -> void:
	if body == Target:
		player_in_area = false
		detected = false

func _on_inner_detection_area_body_entered(body: Node2D) -> void:
	if body == Target:
		player_in_area = true
