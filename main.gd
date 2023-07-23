extends Node

@export var mob_scene : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random locaion on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $SpawnPath/SpawnLocation
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	
	# Run the initialize method to set the mob's position, rotation and velocity.
	mob.initialize(mob_spawn_location.position, $Player.position)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
