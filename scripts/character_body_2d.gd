extends CharacterBody2D

@export var speed = 100
@onready var animationSprite = $AnimatedSprite2D
var facingRight = true

func changeDirections():
	if facingRight:
		animationSprite.flip_h = true
		facingRight = false
	else:
		animationSprite.flip_h = false
		facingRight = true

func _process(delta: float) -> void:
	if Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		if !(Input.is_action_pressed("right") and Input.is_action_pressed("left")):
			if Input.is_action_pressed("left") and facingRight:
				changeDirections()
			elif Input.is_action_pressed("right") and !facingRight:
				changeDirections()
		animationSprite.play("run")
	else:
		animationSprite.play("idle")

func _physics_process(delta):
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * speed
	move_and_slide()
