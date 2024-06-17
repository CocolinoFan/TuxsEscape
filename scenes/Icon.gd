extends Sprite3D


var fish = 5
var player_name = "robot"
var hearts = 3.5
const SPEED = 2
var is_godot_awesome = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(-SPEED))
	elif Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(SPEED))

func minion():
	print("Bana!")

func add_these_numbers(x, y):
	var sun = x + y
	return sun
