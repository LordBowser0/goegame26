extends Node3D

var grow = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if grow:
		scale *= 1.005
	else:
		scale *= 0.995
		
	if scale >= Vector3(1, 1, 1) * 1.5:
		grow = false
	
	if scale <= Vector3(1, 1, 1):
		grow = true
