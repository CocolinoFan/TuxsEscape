extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 10.5

var xform : Transform3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	
	# Rotate the camera left and right
	if Input.is_action_just_pressed("cam_left"):
		$Camera_Controller.rotate_y(deg_to_rad(30))
	if Input.is_action_just_pressed("cam_right"):
		$Camera_Controller.rotate_y(deg_to_rad(-30))
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	#New Vector3 directorion, taking into account he user arrow inputs and the camera rotation
	var direction = ($Camera_Controller.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Rotate the charachter mesh so is pointent in the direction of movement
	if input_dir != Vector2(0,0):
		$MeshInstance3D.rotation_degrees.y = $Camera_Controller.rotation_degrees.y - rad_to_deg(input_dir.angle()) - 90
	
	#Rotate the character to allign with the floor
	if is_on_floor() and input_dir != Vector2(0, 0):
		align_with_floor($RayCast3D.get_collision_normal());
		global_transform = global_transform.interpolate_with(xform, 0.4)
	elif not is_on_floor():
		align_with_floor(Vector3.UP);
		global_transform = global_transform.interpolate_with(xform, 0.4)
		
	#Update the velocity and move the character
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	#Make camera controller match the position of the character movement
	$Camera_Controller.position = lerp($Camera_Controller.position, position, 0.15)

func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()

#Remeber to credit Larry lewing@isc.tamu.edu for makeing the tux image


func _on_fall_zone_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")
