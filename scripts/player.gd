class_name Player extends Entity

@onready var _animated_sprite = $AnimatedSprite2D
@onready var _animation_manager = $AnimationPlayer
@onready var attack_cool_down = $TimerAttackCoolDown

var facingRight = true
enum directions {
	LEFT,
	RIGHT,
	UP,
	DOWN
}
var current_direction = directions.DOWN
enum states {
	RUN,
	IDLE,
	ATTACK,
	HURT,
	DEAD
}
var current_state = states.IDLE

func _ready():
	_animation_manager.play("idle down")

func _process(delta: float) -> void:
	attack()
	moveCharacter()
	changeDirections()

func attack():
	if Input.is_action_just_pressed("attack") and current_state != states.ATTACK:
		current_state = states.ATTACK
		attack_cool_down.start()
		_animation_manager.connect("animation_finished", Callable(self, "_on_attack_finished"))
		match current_direction:
			directions.DOWN:
				_animation_manager.play("attack down")
			directions.UP:
				_animation_manager.play("attack up")
			directions.LEFT:
				_animation_manager.play("attack left")
			directions.RIGHT:
				_animation_manager.play("attack right")

func _on_attack_finished():
	_animation_manager.stop()

func moveCharacter():
	if current_state == states.ATTACK:
		return
	var input_vector = Input.get_vector("left", "right", "up", "down")
	if input_vector != Vector2.ZERO && current_state != states.ATTACK:
		current_state = states.RUN
	velocity = input_vector * speed
	move_and_slide()

func changeDirections():
	if current_state in [states.RUN, states.IDLE]:
		if Input.is_action_pressed("left"):
			_animation_manager.play("run left")
			current_direction = directions.LEFT
		elif Input.is_action_pressed("right"):
			_animation_manager.play("run right")
			current_direction = directions.RIGHT
		elif Input.is_action_pressed("up"):
			_animation_manager.play("run up")
			current_direction = directions.UP
		elif Input.is_action_pressed("down"):
			_animation_manager.play("run down")
			current_direction = directions.DOWN
		elif Input.get_vector("left", "right", "up", "down") == Vector2.ZERO:
			current_state = states.IDLE
			match current_direction:
				directions.DOWN:
					_animation_manager.play("idle down")
				directions.UP:
					_animation_manager.play("idle up")
				directions.LEFT:
					_animation_manager.play("idle left")
				directions.RIGHT:
					_animation_manager.play("idle right")
	


func _on_timer_attack_cool_down_timeout() -> void:
	current_state = states.IDLE
