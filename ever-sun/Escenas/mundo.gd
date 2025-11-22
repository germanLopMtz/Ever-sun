extends Node2D  # Cambia esto si tu escena usa otro nodo raíz

func _input(event):
	if event.is_action_pressed("mostrar_mapa"):
		$MapaImagen.visible = not $MapaImagen.visible
