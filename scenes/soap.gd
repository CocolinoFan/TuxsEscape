extends Area3D

const ROT_SPEED = 0.001 #Number of degrees the fish rotates every frame

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(rad_to_deg(ROT_SPEED))



func _on_body_entered(body):
	queue_free()
