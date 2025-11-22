extends Control

# Referencias que asignas en el Inspector
@export var inventory_data: Inventory
@export var slot_scene: PackedScene

# Referencia al nodo hijo en la escena
@onready var grid_container = %GridContainer

@onready var slotCasco = $PanelPersonaje/SlotCasco
@onready var SlotPechera = $PanelPersonaje/SlotPechera


# Referencia a la barra de vida
@onready var hp_bar = $PanelPersonaje/BarraVida

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
	# Borrar hijos viejos
	for child in grid_container.get_children():
		child.queue_free()
	
	# Crear nuevos hijos
	for slot_data in data.slots:
		var new_slot = slot_scene.instantiate()
		grid_container.add_child(new_slot)
		
		# --- EL CAMBIO IMPORTANTE ---
		# Siempre pasamos el dato, aunque sea null.
		# La función set_slot_data que acabamos de arreglar arriba
		# ya sabe manejar los nulls sin explotar.
		new_slot.set_slot_data(slot_data)
