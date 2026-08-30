extends WalkingEnemy
class_name Dino
@export var bullet_scene: PackedScene
@onready var anim = $AnimatedSprite2D
@onready var timer = $Timer

var last_threshold =0

func _process(delta):
	if dead:
		HP = 0
		return
	palyer_following(520, anim, false)
	var threshold = GameManager.player_points / 12
	if threshold >last_threshold:
		last_threshold=threshold
		timer.wait_time = max(0.9, timer.wait_time - 0.05)
	if HP <= 0:
		die(anim)
	

func shoot():
	if dead or !is_instance_valid(GameManager.player):
		return

	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < 340:
		anim.modulate = Color(0, 0, 1)
		await get_tree().create_timer(0.40).timeout
		anim.modulate = Color(1, 1, 1)
		if dead or !is_instance_valid(GameManager.player):
			return
		var bullet_dir: Vector2 = (GameManager.player.global_position - self.global_position).normalized()
		var bullet = bullet_scene.instantiate()
		bullet.direction = bullet_dir
		bullet.global_position = global_position
		GameManager.spawn_dino_bullet(bullet)
		

func hurt_flush():
	if dead:
			return
	anim.modulate = color_flush
	await get_tree().create_timer(0.1).timeout
	anim.modulate = color_normal
	


func _on_timer_timeout():
	if dead:
			return
	if GameManager.player != null:
		shoot()
	
