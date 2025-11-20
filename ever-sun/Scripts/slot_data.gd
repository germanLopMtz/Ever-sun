extends Resource
class_name SlotData

@export var item_data: ItemData
@export var quantity: int = 1 : set = set_quantity

func set_quantity(value):
	quantity = value
	# Si la cantidad llega a 0, podriamos emitir señal o validarlo luego
