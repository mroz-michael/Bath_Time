extends Node
var anger_meter = 2.5
var clean_progress = 0.0
var started = false
var minigames = []
var gameCounter = 0
var obstaclespeed = -10
var mouse_speed = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ready_minigames()

func ready_minigames() -> void:
	Variablemanager.minigames.append("res://minigames/bubbleRide!/bubble_ride_main.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
