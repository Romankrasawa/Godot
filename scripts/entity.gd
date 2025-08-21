class_name Entity extends CharacterBody2D

@export var speed = 100
@export var maxHealth = 100
@export var health = 100
@export var armour = 10
@onready var animationSprite = $AnimatedSprite

func take_damage(damage: int):
	health = clamp(health - damage, 0 , maxHealth)
