extends StaticBody2D

@export var hardness: int = 1 # how much pick durability is needed to break the block
@export var proc_threshold: float = 0.0 # threshold for procedural generation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func attempt_break(pick_durability: int):
	if hardness <= pick_durability:
		pick_durability = pick_durability - hardness
		# TODO: remove instance on successful break
