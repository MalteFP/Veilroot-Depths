extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -150.0
var currentCollisionMask = 1

func _ready():
	set_collision_mask_value(currentCollisionMask, false)
	get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).z_index = 0
	get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).set_self_modulate(Color(1.0, 1.0, 1.0, 1.0))
	
	set_collision_mask_value(currentCollisionMask, true)
	get_tree().current_scene.get_node("Tilemap/Layer" + str((currentCollisionMask % get_tree().current_scene.get_meta("numLayers")) + 1)).z_index = 1
	get_tree().current_scene.get_node("Tilemap/Layer" + str((currentCollisionMask % get_tree().current_scene.get_meta("numLayers")) + 1)).set_self_modulate(Color(0.173, 0.173, 0.173, 1.0))

func _physics_process(delta: float) -> void:
	applyMovement(delta)
	move_and_slide()

func applyMovement(delta: float) -> void:
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		get_node("AnimatedSprite2D").scale.x = 1
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		get_node("AnimatedSprite2D").scale.x = -1
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	else:
		velocity.y += 300 * delta
	if Input.is_action_just_pressed("switchLayer"):
		set_collision_mask_value(currentCollisionMask, false)
		get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).z_index = 0
		get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).set_self_modulate(Color(0.173, 0.173, 0.173, 1.0))
		currentCollisionMask = (currentCollisionMask % get_tree().current_scene.get_meta("numLayers")) + 1
		set_collision_mask_value(currentCollisionMask, true)
		get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).z_index = 1
		get_tree().current_scene.get_node("Tilemap/Layer" + str(currentCollisionMask)).set_self_modulate(Color(1.0, 1.0, 1.0, 1.0))
	
		
	if Input.is_action_just_released("left") or Input.is_action_just_released("right"):
		velocity.x = 0
