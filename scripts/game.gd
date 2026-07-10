extends Node

var current_position: Node3D = null
var player: Node3D = null
var arrows: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


func new_game():
	current_position = find_child("start_pos", false)
	if current_position == null:
		print("Error: No spawn position was found")
	else:
		print("Start", current_position.position)
	
	player = find_child("player", false)
	if player == null:
		print("Error: No player was found")
	else:
		print("Player", player.position)
		
	walk_to(current_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func walk_to(node: Node3D):
	player.position = node.position
	current_position = node
	make_arrows()


func make_arrows():
	var a_scene = preload("res://scenes/movement_arrows.tscn")
	for arrow in arrows:
		arrow.queue_free()
	arrows.clear()
	
	for pos in current_position.neighbors:
		var instance = a_scene.instantiate()
		add_child(instance)

		instance.global_position = current_position.global_position
		instance.look_at(current_position.get_node(pos).global_position, Vector3.UP)
		instance.rotate_y(deg_to_rad(180))
		arrows.append(instance)
