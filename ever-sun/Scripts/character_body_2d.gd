extends CharacterBody2D

const velocidad = 300

@onready var player = $"."
@onready var animacion = $AnimatedSprite2D
# Referencia al inventario (Ajusta la ruta si le pusiste otro nombre)
@onready var inventario_ui = $CanvasLayer/Inventario

func _physics_process(_delta):
	
	if Input.is_action_pressed("Izquierda"):
		player.position.x -= velocidad * _delta
		animacion.play("Izquierda")

	elif Input.is_action_pressed("Derecha"):
		player.position.x += velocidad * _delta
		animacion.play("Derecha")

	elif Input.is_action_pressed("Arriba"):
		player.position.y -= velocidad * _delta
		animacion.play("Arriba")

	elif Input.is_action_pressed("Abajo"):
		player.position.y += velocidad * _delta
		animacion.play("Abajo")
	else:
		animacion.stop()
	move_and_slide()
	
	
