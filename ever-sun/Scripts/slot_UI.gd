extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel # Asumiendo que añadiste un Label

func set_slot_data(slot_data: SlotData):
	var item = slot_data.item_data
	
	# Si no hay item, ocultamos todo
	if item == null:
		texture_rect.texture = null
		quantity_label.visible = false
		return
		
	# Si hay item, mostramos datos
	texture_rect.texture = item.texture
	
	
	
	
	
	# Lógica visual de cantidad
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.visible = true
	else:
		quantity_label.visible = false # No mostramos "x1", queda más limpio
