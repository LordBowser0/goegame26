extends Node


var flags: Array[bool] = []
var items: Array[bool] = []
var next_event: Main.Followups = Main.Followups.NONE


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	flags.resize(Main.FlagIndices.COUNT)
	flags.fill(false)
	items.resize(Main.ItemIndices.COUNT)
	items.fill(false)
	items[Main.ItemIndices.HAS_SEAL_JAKOB] = true


func get_flag(flag: Main.FlagIndices):
	return flags[flag]
	
func get_item(item: Main.ItemIndices):
	return items[item]
	
func set_flag(flag: Main.FlagIndices):
	flags[flag] = true
	
func give_item(item: Main.ItemIndices):
	items[item] = true

func unset_flag(flag: Main.FlagIndices):
	flags[flag] = false
	
func remove_item(item: Main.ItemIndices):
	items[item] = false
