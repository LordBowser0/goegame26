extends Node

var current_position: Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_position = find_child("start_pos", false)
	if current_position == null:
		print("Error: No spawn position was found")
	else:
		print(current_position.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
