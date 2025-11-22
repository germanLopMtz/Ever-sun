extends PanelContainer

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $QuantityLabel 

# --- 1. VARIABLE NUEVA ---
# Necesitamos guardar los datos aquí para poder usarlos al arrastrar
var slot_data: SlotData

func set_slot_data(data: SlotData):
	slot_data = data
	
	# 1. RESETEO TOTAL: Primero borramos todo visualmente (Limpieza)
	texture_rect.texture = null
	quantity_label.visible = false
	
	# 2. VALIDACIONES:
	# Si el slot es nulo, nos vamos (ya lo limpiamos arriba)
	if slot_data == null:
		return
	
	# Si el slot existe pero no tiene ItemData (objeto), nos vamos
	if slot_data.item_data == null:
		return
		
	# 3. PINTAR DATOS (Solo si llegamos aquí, es que hay un objeto real)
	texture_rect.texture = slot_data.item_data.texture
	
	# Solo mostramos la cantidad si es mayor a 1
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.visible = true

# --- 2. FUNCIONES DE ARRASTRAR Y SOLTAR (DRAG & DROP) ---

# A. Detectar cuando empiezas a arrastrar
# Reemplaza tu función _get_drag_data con esta:
func _get_drag_data(_at_position):
	# 1. Validar: Si no hay datos o no hay item, no se arrastra nada.
	if slot_data == null or slot_data.item_data == null:
		return null
		
	# 2. Crear el "Fantasma" visual
	var preview_texture = TextureRect.new()
	
	# --- LA CLAVE DEL PIXEL ART ---
	# Usamos el icono real del objeto
	preview_texture.texture = slot_data.item_data.texture
	# Forzamos el filtro "Nearest" para que NO se vea borroso
	preview_texture.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	# Configuración de tamaño (ajústalo al tamaño de tus slots, ej. 40x40 o 32x32)
	preview_texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview_texture.custom_minimum_size = Vector2(40, 40) 
	preview_texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	
	# 3. Contenedor para el fantasma (necesario para centrarlo)
	var preview = Control.new()
	preview.add_child(preview_texture)
	# Centramos el fantasma en la punta del mouse
	preview_texture.position = -0.5 * preview_texture.custom_minimum_size
	
	# 4. Mostrar el fantasma
	set_drag_preview(preview)
	
	# 5. Retornar los datos
	return slot_data
	
# B. Preguntar si puedo soltar algo aquí
func _can_drop_data(at_position, data):
	# Solo aceptamos si lo que arrastras es de tipo SlotData
	return data is SlotData

# C. Qué pasa cuando sueltas el click
func _drop_data(_at_position, data):
	# PROTECCIÓN: Si este slot destino está "virgen" (null), creamos un dato vacío
	if slot_data == null:
		slot_data = SlotData.new()
	
	# Ahora sí, el intercambio seguro
	var temp_item = slot_data.item_data
	var temp_quantity = slot_data.quantity
	
	slot_data.item_data = data.item_data
	slot_data.quantity = data.quantity
	
	data.item_data = temp_item
	data.quantity = temp_quantity
	
	# Actualizamos visualmente
	set_slot_data(slot_data)
	# Opcional: Si el origen necesita actualizarse, aquí iría la señal.
