extends Resource
class_name Inventory

signal inventory_updated(inventory_data: Inventory)

# En lugar de una lista dinámica, usamos una exportada para definir el tamaño fijo
@export var slots: Array[SlotData]

func insert_item(item: ItemData):
	# 1. Intentar apilar (Stacking) si el objeto es apilable
	if item.is_stackable:
		for slot in slots:
			if slot.item_data == item: # Si ya tengo este item
				slot.quantity += 1
				inventory_updated.emit(self)
				return # Terminamos, ya lo sumamos

	# 2. Si no se pudo apilar, buscar el primer espacio vacío
	for i in range(slots.size()):
		if slots[i].item_data == null: # Encontramos un hueco vacío
			slots[i].item_data = item
			slots[i].quantity = 1
			inventory_updated.emit(self)
			return
			
	# 3. Si llegamos aquí, el inventario está lleno
	print("¡Inventario lleno!")
