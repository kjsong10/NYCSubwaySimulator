extends GutTest


class TestPlayerSpawnMain:
	extends GutTest
	var main = load("res://main.tscn")
	var player = load("res://player.tscn")
	var main_instance = null
	var player_instance = null
	
	func before_each():
		main_instance = main.instantiate()
		
	func after_each():
		main_instance.free()

# this tests if player was spawned in correct position and its parent is main
	func test_position():
		player_instance = main_instance.get_node("Player")
		var pos = Vector3(0, 0, 0)
		assert_eq(player_instance.global_transform.origin, pos, "Should be equal to starting position")
		assert_eq(player_instance.get_parent().name,"Main","Should be equal to Main")
		
	# trying to test that current scene is 137, but having issues
	#func test_tp_137():
		#player_instance = main_instance.get_node("Player")
		#var station137_tp = main_instance.get_node("137/go_to_137")
		#player_instance.translate(Vector3(6,-1,-35))
		#print(player_instance.global_transform.origin)
		#watch_signals(station137_tp)
		#watch_signals(player_instance)
		#player_instance. _on_go_to_137_body_entered(station137_tp)
		#assert_signal_emitted(station137_tp, "body_entered" , "Should be true")
		
		
		
		
	

	
