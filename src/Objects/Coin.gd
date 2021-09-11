extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_Coin_body_entered(body):
	anim_player.play("FadeOut")
