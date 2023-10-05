extends Node

# properties
@export var player: CharacterBody2D # player refernce
@export var move_speed: float = 1.0 # speed the player should move towards target
@export var step_size: float = 1.0 # rate of change for target alteration

var target = Vector2(0.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	# make sure player reference is set
	assert(player != null, "ERR: PLAYER REFERENCE NOT SET")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move player if not at target
	if not vectors_approx_equal(player.position,target):
		player.move(delta)

func _input(event):
	# process input event
	if event.is_action_pressed("player_up"): # move up
		target = target + Vector2(0, -1) * step_size
	elif event.is_action_pressed("player_left"): # move left
		target = target + Vector2(-1, 0) * step_size
	elif event.is_action_pressed("player_down"): # move down
		target = target + Vector2(0, 1) * step_size
	elif event.is_action_pressed("player_right"): # move right
		target = target + Vector2(1, 0) * step_size

func move(delta):
	# determine x and y to move towards
	var c_pos = player.position
	var adjusted_speed = delta * move_speed
	var distance_to_target = abs(get_distance(target, c_pos))
	var n_pos: Vector2
	if distance_to_target < adjusted_speed:
		n_pos = target
	else:
		n_pos = Vector2(move_toward(c_pos.x, target.x, adjusted_speed),
	 		move_toward(c_pos.y, target.y, adjusted_speed))
	
	print("moving to " + str(n_pos) +
		"(currently at " + str(c_pos) + ")")
	
	# perform movement step
	player.velocity = n_pos
	player.move_and_slide()

func vectors_approx_equal(a: Vector2, b: Vector2) -> bool:
	"""
	Helper function that returns whether two vectors are approximately equal.
	:param a: The first vector to compare
	:param b: The second vector to compare
	:returns: ``true`` if the vectors' components are approximately equal,
	 false otherwise
	"""
	return is_equal_approx(a.x, b.x) and is_equal_approx(a.y, b.y)
	
func get_distance(a: Vector2, b: Vector2) -> float:
	return sqrt(pow(b.x - a.x, 2) + pow(b.y - a.y, 2))
