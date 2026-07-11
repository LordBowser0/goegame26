extends CanvasLayer

signal event_chosen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"option 1".pivot_offset = $"option 1".size / 2
	$"option 2".pivot_offset = $"option 2".size / 2
	$"option 3".pivot_offset = $"option 3".size / 2
	$"option 4".pivot_offset = $"option 4".size / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

## todo remove
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			visible = !visible


func _on_textbox_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Rich text clicked")

var scaling = 1.05

func _on_option_1_mouse_entered() -> void:
	$"option 1".scale *= scaling


func _on_option_1_mouse_exited() -> void:
	$"option 1".scale = Vector2.ONE


func _on_option_2_mouse_entered() -> void:
	$"option 2".scale *= scaling


func _on_option_2_mouse_exited() -> void:
	$"option 2".scale = Vector2.ONE


func _on_option_3_mouse_entered() -> void:
	$"option 3".scale *= scaling


func _on_option_3_mouse_exited() -> void:
	$"option 3".scale = Vector2.ONE


func _on_option_4_mouse_entered() -> void:
	$"option 4".scale *= scaling


func _on_option_4_mouse_exited() -> void:
	$"option 4".scale = Vector2.ONE


func _on_option_1_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Option 1")
			visible = false
			event_chosen.emit()


func _on_option_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Option 2")
			visible = false
			event_chosen.emit()


func _on_option_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Option 3")
			visible = false
			event_chosen.emit()


func _on_option_4_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Option 4")
			visible = false
			event_chosen.emit()
