extends WalkingEnemy
class_name Spider
@onready var anim = $AnimatedSprite2D
@export var bullet_scene: PackedScene
@onready var shooting_timer = $ShootingTimer
var last_threshold =0

func _ready():
	GameManager.spider = self


func _process(delta):
	if dead:
		HP = 0
		return
	palyer_following(310, anim, false)
	var threshold = GameManager.player_points / 2
	if threshold > last_threshold:
		last_threshold=threshold
		shooting_timer.wait_time = max(3, shooting_timer.wait_time - 0.03)
	if HP <= 0:
		die(anim)

		
func hurt_flush():
	if dead:
			return
	anim.modulate = color_flush
	await get_tree().create_timer(0.1).timeout
	anim.modulate = color_normal 

func shoot():
	if dead or !is_instance_valid(GameManager.player):
		return
	if GameManager.player_already_slowed:
		return
	var distance= global_position.distance_to(GameManager.player.global_position)
	if distance < 300:
		anim.modulate = Color(0, 0, 1)
		await get_tree().create_timer(0.40).timeout
		anim.modulate = Color(1, 1, 1)
		var bullet_dir: Vector2 = (GameManager.player.global_position - self.global_position).normalized()

		var bullet = bullet_scene.instantiate()
		bullet.direction = bullet_dir
		bullet.global_position = global_position
		GameManager.spawn_spider_bullet(bullet)

func _on_shooting_timer_timeout():
	if dead:
			return
	if GameManager.player != null:
		shoot()

func _on_hurt_for_player_body_entered(body: Node2D):
	if dead:
		return
	if body.name == "CharacterBody2D":
		GameManager.player.HP -=1
		GameManager.player.hurt_flush()

