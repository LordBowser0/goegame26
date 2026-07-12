extends OmniLight3D

var random_value: float = 5
@export var interval :float = 0.1

func _ready() -> void:
	var timer := Timer.new()
	timer.wait_time = interval
	timer.autostart = true
	timer.one_shot = false
	add_child(timer)

	timer.timeout.connect(func():
		random_value = randf_range(4, 7)
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	light_energy = lerp(light_energy, random_value, 0.03/interval)
	
