class_name Player extends Entity

var facingRight = true

func _process(delta: float) -> void:
	moveCharacter()
	changeDirections()

func moveCharacter():
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector * speed
	move_and_slide()

func changeDirections():
	if Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		if !(Input.is_action_pressed("right") and Input.is_action_pressed("left")):
			if Input.is_action_pressed("left") and facingRight:
				animationSprite.flip_h = true
				facingRight = false
			elif Input.is_action_pressed("right") and !facingRight:
				animationSprite.flip_h = false
				facingRight = true
		animationSprite.play("run")
	else:
		animationSprite.play("idle")
