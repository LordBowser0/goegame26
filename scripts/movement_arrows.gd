extends Node3D

@export var destination: NodePath

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		get_parent().walk_to(get_node(destination))
