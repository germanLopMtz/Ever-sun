extends Control

# Referencias que asignas en el Inspector
@export var inventory_data: Inventory
@export var slot_scene: PackedScene

# Referencia al nodo hijo en la escena
@onready var grid_container = $GridContainer

func _ready():
	# Validamos que hayas arrastrado el recurso al Inspector
	if inventory_data:
		# Conectamos la señal para que se actualice automáticamente
		inventory_data.inventory_updated.connect(update_inventory_visuals)
		# Hacemos la primera carga visual
		update_inventory_visuals(inventory_data)
	else:
		push_warning("ADVERTENCIA: No has asignado un InventoryData en el Inspector de InventoryUI.")

func update_inventory_visuals(data: Inventory):
	# 1. LIMPIEZA: Borramos todos los slots viejos
	for child in grid_container.get_children():
		child.queue_free()
	
	# 2. CREACIÓN: Recorremos cada espacio de tu inventario
	for slot_data in data.slots:
		var new_slot = slot_scene.instantiate()
		grid_container.add_child(new_slot)
		
		# --- AQUÍ ESTABA EL ERROR ---
		# Verificamos si el espacio tiene datos (SlotData) o si está vacío (null).
		if slot_data != null:
			new_slot.set_slot_data(slot_data)
		else:
			# Si es null (espacio vacío en el array), no hacemos nada.
			# El slot visual se quedará con su apariencia por defecto (vacío).
			pass
