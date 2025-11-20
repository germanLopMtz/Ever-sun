extends Control

# 1. Referencia al Recurso de Inventario (Datos)
@export var inventory_data: Inventory 

# 2. Referencia a la Escena visual del Slot (Lo que vamos a clonar)
@export var slot_scene: PackedScene 

# 3. Referencia al nodo GridContainer (Donde pondremos los clones)
@onready var grid_container = $GridContainer

func _ready():
	# Nos conectamos a la señal que creamos antes en el script del Inventario.
	# Esto hace que la UI se actualice sola cuando reciba el aviso.
	if inventory_data:
		inventory_data.inventory_updated.connect(update_inventory_visuals)
		update_inventory_visuals(inventory_data)
	else:
		print("ERROR: ¡No has asignado un Recurso de Inventario en el Inspector!")

# Esta es la función principal del Paso 4
func update_inventory_visuals(data: Inventory):
	# A. LIMPIEZA: Eliminar los slots antiguos para no duplicarlos
	for child in grid_container.get_children():
		child.queue_free()
	
	# B. CREACIÓN: Recorrer todos los datos de slots del inventario
	for slot_data in data.slots:
		# Instanciamos (clonamos) la escena visual del Slot
		var new_slot = slot_scene.instantiate()
		
		# Lo añadimos como hijo del GridContainer
		grid_container.add_child(new_slot)
		
		# C. INYECCIÓN DE DATOS: Le pasamos la info al slot visual
		# Llamamos a la función que creamos en el paso anterior dentro del SlotUI
		if new_slot.has_method("set_slot_data"):
			new_slot.set_slot_data(slot_data)
