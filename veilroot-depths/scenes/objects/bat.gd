extends Node2D

@onready var sprite = get_node("AnimatedSprite2D")

@onready var finalPos = get_node("FinalPosMarker").global_position

func _ready() -> void:
	sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_appear_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player"
		sprite.scale = Vector2(0,0)
		sprite.visible = true
		sprite.play("idle")
		for i in range(10):
			sprite.scale += Vector2(0.05,0.05)
			await get_tree().create_timer(0.1).timeout
		sprite.play("flying")
		while not global_position == finalPos:
			global_position = global_position.move_toward(finalPos, 1)
			await get_tree().create_timer(0.01).timeout
		sprite.play("idle")
