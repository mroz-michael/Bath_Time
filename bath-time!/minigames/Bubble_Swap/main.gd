extends Node2D

@export var tile_without_bubble: Texture2D
@export var tile_with_bubble: Texture2D
@onready var TileScene = preload("res://minigames/Bubble_Swap/Tile.tscn");
@onready var timer = $Timer;
@onready var countdown = $ClockLabel;
@onready var exit_button = $exit_button;
@onready var game_over_text = $GameOverText;
@onready var title_screen = $TitleScreen;
@onready var start_button = $start_button;


const GRID_SIZE = 3;
var board_size: int;
var tile_size: int;
var tile_coordinate: Vector2;
var grid = []
var score: int;
var click_count = 0;
var good_solution: int; #num of moves from initial solved state to player's starting configuration
var time_allowed = 30;
var game_active = false;

func _ready():
	# UI info
	board_size = 600;
	tile_size = board_size / GRID_SIZE
	exit_button.hide()
	game_over_text.hide()
	countdown.hide()
	$Board.hide()
	countdown.add_theme_font_size_override("font_size", 64);
	start_button.text = "START"
	$music.play()


func _process(delta: float):
	if not timer.is_stopped() and game_active:
		countdown.text = str(round(timer.time_left));
		if timer.time_left <= 10:
			countdown.add_theme_color_override("font_color", Color(1, 0, 0));

func _input(event):
	if game_active and event is InputEventMouseButton:
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
		toggle_tile(x, y, true)

func toggle_tile(x, y, prep=false):
	
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
	
	if solved() and not prep:
		game_over(true);

func solved():
	for row in grid:
		for tile in row:
			if not tile.has_bubble():
				return false
	return true
	
func game_over(solved):
	game_active = false;
	$Board.hide();
	$music.stop()
	for row in grid:
		for tile in row:
			remove_child(tile)
	countdown.hide();
	game_over_text.show();
	var final_clickcount = click_count;
	if (solved and final_clickcount <= good_solution):
		game_over_text.text = "AMAZING! You solved the puzzle in very few moves!"
		score = 12;
	elif (solved):
		game_over_text.text = "Great job solving the puzzle!"
		score = 8;
	else:
		var fstring = "Time's Up! You clicked {click_count} times. An almost optimal solution required roughly {good_solution} clicks"
		game_over_text.text = fstring.format({"click_count": click_count, "good_solution": good_solution}) 
		score = 3;
	await get_tree().create_timer(1).timeout;
	add_child(exit_button);
	exit_button.text = "Get Back to Scrubbing"
	exit_button.show();

func _on_timer_timeout():
	game_over(false);
	
#return score as weighted_score for main game, give control back to main game
func _on_exit_button_pressed() -> void:
	#Variablemanager.anger_meter = Variablemanager.anger_meter - score;
	#1920 x 1080
	if (Variablemanager.gameCounter < len(Variablemanager.minigames)):
		Variablemanager.gameCounter += 1
	Variablemanager.anger_meter = Variablemanager.anger_meter - score
	Variablemanager.globalscore += score
	get_window().size = Vector2i(1920, 1080)
	get_tree().change_scene_to_file("res://main.tscn");


func _on_start_button_pressed() -> void:
	start_button.hide();
	title_screen.hide();
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
	countdown.show()
	countdown.text = str(timer.wait_time);
