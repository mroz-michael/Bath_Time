extends Node2D

@export var tile_without_bubble: Texture2D
@export var tile_with_bubble: Texture2D
@onready var TileScene = preload("res://minigames/Bubble_Swap/Tile.tscn");
@onready var timer = $Timer;
@onready var countdown = $ClockLabel;

const GRID_SIZE = 3;
var board_size: int;
var tile_size: int;
var tile_coordinate: Vector2;
var grid = []
var score: int;
var click_count = 0;
var good_solution: int; #num of moves from initial solved state to player's starting configuration
var time_allowed = 30;
var game_active = true;

func _ready():
	# UI info
	board_size = 600;
	tile_size = board_size / GRID_SIZE

	countdown.add_theme_font_size_override("font_size", 64);
	
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
	#go from solved state to starting state
	shuffle_grid();
	#incase shuffle solves grid, reshuffle:
	while (solved()):
		shuffle_grid();
	game_active = true;
	timer.wait_time = time_allowed;
	timer.start();
	countdown.text = str(timer.wait_time);

func _process(delta: float):
	if not timer.is_stopped() and game_active:
		countdown.text = str(round(timer.time_left));
		if timer.time_left <= 10:
			countdown.add_theme_color_override("font_color", Color(1, 0, 0));

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

#go from a solved state to a random unsolved starting configuration
func shuffle_grid():
	var shuffle_count = randi() % 10 + 5
	good_solution = shuffle_count;
	for i in range(shuffle_count):
		var x = randi() % GRID_SIZE
		var y = randi() % GRID_SIZE
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
	game_active = false;
	countdown.remove_theme_color_override("font_color");
	countdown.remove_theme_font_size_override("font_size");
	if (solved and click_count <= good_solution):
		countdown.text = "AMAZING! You solved the puzzle in very few moves!"
		score = 12;
	elif (solved):
		countdown.text = "Great job solving the puzzle!"
		score = 8;
	else:
		var fstring = "Time's Up! You clicked {click_count} times. An almost optimal solution required roughly {good_solution} clicks"
		countdown.text = fstring.format({"click_count": click_count, "good_solution": good_solution}) 
		score = 3;
	
	#return score as weighted_score for main game, give control back to main game


func _on_timer_timeout():
	game_over(false);
	
