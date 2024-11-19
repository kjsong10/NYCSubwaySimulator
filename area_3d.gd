extends Area3D

# Set the default respawn position for the player
var default_position = Vector3(0, 0, 0)  # Replace with your desired coordinates

func _on_area_entered(area):
	if area.is_in_group("player"):  # Make sure your player is in the "player" group
		area.global_transform.origin = default_position  # Teleport the player
