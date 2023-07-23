extends CharacterBody3D

# How fast the player moves in meters per second.
@export var speed = 14
# The downward acceleration when in the air, in meters per second squared.
@export var fall_acceleration = 75
# The direction in which to move the character. Zero vector by default (no player input).
# Defined as a property to reuse its value across frames.
# In 3D, the distance unit is meters. In 2D, it's the pixel - very different scales!
var target_velocity = Vector3.ZERO

func _physics_process(delta):
	# We create a local variable to store the input direction
	var direction = Vector3.ZERO
	
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_up"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground.
		direction.z -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	
	# Prevent faster movement along the diagonals by normailizing all movement vectors
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
	
	# Ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed
	
	# Vertical velocity
	if not is_on_floor(): # If in the air, fall towards the floor, i.e apply gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	
	# Moving the Player
	self.velocity = target_velocity
	move_and_slide() 
	
