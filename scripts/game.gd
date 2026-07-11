extends Node
class_name Main

var current_position: Node3D = null
var player: Node3D = null
var arrows: Array = []

enum LocationEvents {
	NONE,
	WINE,
	TAVERN
}

enum FigureEvents {
	NONE,
	WOLF,
	FROG,
	RAVEN
}

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


## CORE GAME LOOP
# first, the player walks to a node
func walk_to(node: Node3D):
	print_debug("Now walking to: ", node)
	
	# remove all arrows
	for arrow in arrows:
		arrow.queue_free()
	arrows.clear()
	
	player.position = node.position
	current_position = node
	# next, events trigger:
	# first, events regarding other present figures
	if false:
		trigger_figure(FigureEvents.NONE)
	# if no figure is present, an event regarding the current space can happen
	else:
		trigger_location(current_position.event)
	# function ends while waiting for player choices


# continue turn after choosing event
func _on_event_event_chosen() -> void:
	# all other figures move according to their pattern
	## todo
	# make arrows to allow the player to move
	make_arrows()

func make_arrows():
	var a_scene = preload("res://scenes/movement_arrows.tscn")
	
	for pos in current_position.neighbors:
		var instance = a_scene.instantiate()
		add_child(instance)
		instance.destination = pos
		instance.global_position = current_position.global_position
		instance.look_at(current_position.get_node(pos).global_position, Vector3.UP)
		instance.rotate_y(deg_to_rad(180))
		arrows.append(instance)


func trigger_figure(event:FigureEvents):
	_on_event_event_chosen()


func trigger_location(event: LocationEvents):
	match event:
		LocationEvents.NONE:
			_on_event_event_chosen()
		LocationEvents.WINE:
			$event.visible = true
		LocationEvents.TAVERN:
			$event.visible = true
