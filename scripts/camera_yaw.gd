extends Node3D

@export var rotation_speed_yaw := 90.0 # degrees per second

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta):
	var y_direction := Input.get_axis("camera_left", "camera_right")

	if y_direction != 0:
		rotate_y(deg_to_rad(y_direction * rotation_speed_yaw * delta))
