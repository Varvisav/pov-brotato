extends CharacterBody2D
class_name Bomb

@onready var anim = $AnimatedSprite2D
#@onready var hp_label: Label= $HpLabel
var dead = false

func _ready():
	pass

func _physics_process(delta):
	if dead:
		return
	if !is_instance_valid(GameManager.player):
		anim.play("idle")
		return

func boom():
	GameManager.zombie_toast=null
	dead = true
	#hp_label.text = str(0)
	anim.play("boom")
	await anim.animation_finished
	queue_free()
