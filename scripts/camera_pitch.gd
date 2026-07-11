extends Node3D

@export var rotation_speed_pitch := 90.0 # degrees per second

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotation.x = deg_to_rad(-20)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir := Input.get_axis("camera_up", "camera_down")
	rotation.x += deg_to_rad(dir * rotation_speed_pitch * delta)

	# Prevent flipping over
	rotation.x = clamp(rotation.x,
		deg_to_rad(-80),
		deg_to_rad(0))
