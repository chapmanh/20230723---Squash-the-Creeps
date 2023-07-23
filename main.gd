extends Node

@export var mob_scene : PackedScene


func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene
	var mob = mob_scene.instantiate()
	
	# Choose a random locaion on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mob_spawn_location = $SpawnPath/SpawnLocation
	# And give it a random offset.
	mob_spawn_location.progress_ratio = randf()
	
	# Run the initialize method to set the mob's position, rotation and velocity.
	var player_position = $Player.position
	player_position.y = mob_spawn_location.position.y
	mob.initialize(mob_spawn_location.position, player_position)
	
	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func _on_player_hit():
	$MobTimer.stop()
