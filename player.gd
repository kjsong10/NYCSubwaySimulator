extends CharacterBody3D


const DEFAULT_SPEED = 10.0
var SPEED = DEFAULT_SPEED
const JUMP_VELOCITY = 6
@onready var neck := $Neck
@onready var camera := $Neck/Camera
@onready var win_message_label = $"/root/Main/CanvasLayer/Label"

@onready var train_arrived = false


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.01)
			camera.rotate_x(-event.relative.y * 0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("turn_left"):
		neck.rotate_y(0.04)
	if Input.is_action_pressed("turn_right"):
		neck.rotate_y(-0.04)
	if Input.is_action_pressed("run"):
		SPEED = 20
	if Input.is_action_just_released("run"):
		SPEED = DEFAULT_SPEED
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_entered(body: Node3D) -> void:
	self.position.x = 0
	self.position.y = 0
	self.position.z = 0


func _on_win_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player")):
		print("Success!") # Replace with function body.
		win_message_label.visible = true


func _on_win_body_exited(body: Node3D) -> void:
	win_message_label.visible = false



func _on_go_to_137_body_entered(body: Node3D) -> void:
	print("going to 137")
	if(get_tree() != null):
		get_tree().change_scene_to_file("res://137.tscn")


func _on_main_child_entered_tree(node: Node) -> void:
	print(global_position)
	pass # Replace with function body.


func _on__child_entered_tree(node: Node) -> void:
	print(global_position)
	pass # Replace with function body.


func _on_summon_train_body_entered(body: Node3D) -> void:
	if(body.is_in_group("player") and !train_arrived):
		var train = $"/root/137/Train"
		train.set_visible(true)
		var animPlayer: AnimationPlayer = $"/root/137/Train/AnimationPlayer"
		animPlayer.play("Enter Station")
		train_arrived = true

