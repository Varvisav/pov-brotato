class_name Player extends CharacterBody2D

@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var camera = $Camera2D
var alive = true
var HP: int = 40

func _input(_event):
	if Input.is_action_just_pressed("shoot"):
		self._shoot()

func _ready():
	GameManager.player = self
	

func _physics_process(_delta: float) -> void:
	if alive == false:
		HP = 0
		return
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * GameManager.player_speed
	if direction:
		anim.play("walk")
	else:
		anim.play("idle") 
	if direction.x < 0:
		anim.flip_h = true
	elif direction.x >0:
		anim.flip_h = false
	move_and_slide()
	if GameManager.player.HP <= 0:
		death()
	
	
func _shoot():
	if alive == false:
		return
	var mouse_pos: Vector2 = get_global_mouse_position()
	var bullet_dir: Vector2 = (mouse_pos - self.global_position).normalized()

	var bullet: PlayerBullet = bullet_scene.instantiate()
	bullet.direction = bullet_dir
	bullet.global_position = global_position
	GameManager.spawn_bullet(bullet)

func death():
	alive = false
	anim.play("death")
	await anim.animation_finished
	GameManager.player=null
	var tween = create_tween()
	#await get_tree().create_timer(2).timeout
	tween.tween_property(camera, "zoom", Vector2(4, 4), 60)
	
	GameManager.show_game_over()
	
	
func hurt_flush():
	anim.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.17).timeout
	anim.modulate = Color(1,1,1)
	


#func _on_hurt_box_area_entered(area):
	#if alive == false:
	#		return
	#if area.name == "Area2D":
	#	hurt_flush()
