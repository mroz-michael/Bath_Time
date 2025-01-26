extends Node2D

@export var tile_without_bubble: Texture2D
@export var tile_with_bubble: Texture2D
@onready var TileScene = preload("res://minigames/Bubble_Swap/Tile.tscn");

const GRID_SIZE = 3;
var board_size: int;
var tile_size: int;
var tile_coordinate: Vector2;
var grid = []
var score: int;
var click_count = 0;
var optimal_solution: int; #num of moves from initial solved state to player's starting configuration

func _ready():
	# UI info
	board_size = 600;
	tile_size = board_size / GRID_SIZE
	
	for i in range(GRID_SIZE):
		var row = []
		grid.append(row)
		for j in range(GRID_SIZE):
			var tile = TileScene.instantiate()
			tile.set_val(1)
			# Set tile position centered within its cell
			tile.position = Vector2(j * tile_size + tile_size / 2, i * tile_size + tile_size / 2)
			add_child(tile)
			row.append(tile)
	
	shuffle_grid();

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if event.position.x < board_size:
				click_count += 1;
				#convert coordinate of cell to array index
				tile_coordinate = event.position / tile_size
				# Ensure the tile coordinates are integers when accessing the grid
				tile_coordinate = tile_coordinate.floor() 
				toggle_tile(tile_coordinate.x, tile_coordinate.y)

#go from a solved state to an unsolved state starting configuration
func shuffle_grid():
	var shuffle_count = randi() % 10 + 5
	optimal_solution = shuffle_count;
	print(optimal_solution);
	for i in range(shuffle_count):
		var x = randi() % GRID_SIZE
		var y = randi() % GRID_SIZE
		print("toggle [",y, ", ",x , "]" )
		toggle_tile(x, y)

func toggle_tile(x, y):
	
	grid[y][x].swap_val()
	#Toggle all neighbours if exist
	var has_left = x > 0
	var has_right = x < GRID_SIZE - 1
	var has_top = y > 0
	var has_bot = y < GRID_SIZE - 1
	if has_left:
		grid[y][x - 1].swap_val()
	if has_right:
		grid[y][x  + 1].swap_val()
	if has_top:
		grid[y - 1][x].swap_val()
	if has_bot:
		grid[y + 1][x].swap_val()
	
	if solved():
		game_over(true);

func solved():
	for row in grid:
		for tile in row:
			if not tile.has_bubble():
				return false
	return true
	
func game_over(solved):
	if (solved and click_count == optimal_solution):
		score = 10;
	elif (solved):
		score = 5;
	else:
		score = 2;
	
## WEIGHTED_SCORE STUFF
#func find_score_weight:
	#if (score > )
