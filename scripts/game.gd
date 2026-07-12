extends Node
class_name Main

var current_position: Node3D = null
var last_position: Node3D = null
var player: Node3D = null
var arrows: Array = []

enum LocationEvents {
	NONE,
	WINE_CELLAR,
	TAVERN,
	GRANDMA,
	ROSE_BUSH, ## sleeping beauty
	ALLEY, ## snow white
	DWARVES,
	WELL,
	GOOSE,
	RED,
	COUNT
}

enum FigureEvents {
	NONE,
	WOLF,
	FROG,
	RAVEN,
	PRINCE,
	HUNTSMAN,
	SISTER,
	COUNT
}

enum Followups {
	NONE,
	FOUND_CLUB,
	FOUND_SACK,
	FROG_FIGHT,
	GOOSE_1,
	GOOSE_2,
	GOOSE_KISS,
	GRANDMA_ABOUT,
	GRANDMA_RED,
	GHOST_EXITS_BOTTLE,
	GRANDMA_WINE,
	GHOST_DEATH,
	GRANDMA_AGAIN,
	SW_KISS,
	SW_SLAP,
	SLEEP_KISS,
	SLEEP_SLAP,
	GRANDMA_SUCCESS,
	GRANDMA_CLUB,
	GRANDMA_HUNTER,
	RED_AGAIN,
	RED_LEAVE,
	RED_ABOUT,
	COUNT
}

enum FlagIndices {
	FOUND_CLUB,
	RELEASED_GHOST,
	FOUND_WINE,
	FROG_WOLF,
	FROG_GOOSE,
	MET_FROG,
	MET_RED,
	FOUND_SW,
	FOUND_SLEEP,
	DEFEATED_WOLF,
	FOUND_WOODSMAN,
	COUNT
}

enum ItemIndices {
	HAS_CLUB,
	HAS_GHOST, # "Wine" bottle
	HAS_WINE,
	HAS_BREADCRUMBS,
	HAS_SEAL_JAKOB,
	HAS_SEAL_ALBRECHT,
	HAS_SEAL_DAHLMANN,
	HAS_SEAL_EWALD,
	HAS_SEAL_GERVINUS,
	HAS_SEAL_WEBER,
	HAS_SEAL_WILHELM,
	COUNT ## to initialize array size
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


## CORE GAME LOOP
# first, the player walks to a node
func walk_to(node: Node3D):
	last_position = current_position
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
	if Globals.next_event != Followups.NONE:
		trigger_followup(Globals.next_event)
		return
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


func trigger_figure(event: FigureEvents):
	match event:
		FigureEvents.NONE:
			_on_event_event_chosen() # should not happen
		_:
			$event.trigger(LocationEvents.COUNT + event)


func trigger_location(event: LocationEvents):
	match event:
		LocationEvents.NONE:
			_on_event_event_chosen()
		_:
			$event.trigger(event)


func trigger_followup(event: Followups):
	match event:
		Followups.NONE:
			_on_event_event_chosen() # should not happen
		_:
			$event.trigger(LocationEvents.COUNT + FigureEvents.COUNT + event)

func _on_event_go_back() -> void:
	walk_to(last_position)
