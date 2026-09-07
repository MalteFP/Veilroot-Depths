extends Node2D

@onready var sprite = get_node("AnimatedSprite2D")

@onready var finalPos = get_node("FinalPosMarker").global_position

var appeared = false
var done = false
func _ready() -> void:
	sprite.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_appear_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player" and appeared == false:
		appeared = true
		sprite.scale = Vector2(0,0)
		sprite.visible = true
		sprite.play("idle")
		for i in range(10):
			sprite.scale += Vector2(0.05,0.05)
			await get_tree().create_timer(0.1).timeout
		sprite.play("flying")
		while not sprite.global_position == finalPos:
			sprite.global_position = sprite.global_position.move_toward(finalPos, 1)
			await get_tree().create_timer(0.01).timeout
		sprite.play("idle")
		get_node("AnimatedSprite2D/Sprite2D").visible = true


func _on_disappear_box_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "player" and appeared == true and done == false:
		done = true
		get_node("AnimatedSprite2D/Sprite2D").visible = false
		sprite.play("flyaway")
		for i in range(100):
			sprite.scale -= Vector2(0.005,0.005)
			await get_tree().create_timer(0.1).timeout
