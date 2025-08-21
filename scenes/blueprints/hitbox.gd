extends Area2D

@export var damage = 10
@export var knockback_strength = 1500
var cant_attack = false
enum directions {
	LEFT,
	RIGHT,
	UP,
	DOWN
}

func get_knockback_direction():
	var player = get_parent()
	match player.current_direction:
		directions.DOWN:
			return Vector2.DOWN * knockback_strength
		directions.UP:
			return Vector2.UP * knockback_strength
		directions.LEFT:
			return Vector2.LEFT * knockback_strength
		directions.RIGHT:
			return Vector2.RIGHT * knockback_strength
