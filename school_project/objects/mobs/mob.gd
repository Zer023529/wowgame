extends KinematicBody2D

var gravity_f: int = -500
var speed: int = 200
var speed_to_player: int

var event: bool = false
var speed_b: bool = false
var atack: bool = false
var move: bool = true
var was_jump: bool = false
var start: bool = false
var find_vel: bool = true

func _ready():
	$sprite_m.play()


func _physics_process(delta):
	
	randomize()
	
	event = get_parent().get_parent().get_parent().get_parent().event
	
	if !event and start:
		
		if !was_jump:
			
			if is_on_wall():
				gravity_f = 0
			
			else:
				gravity_f = -500
		
		if abs(get_parent().get_parent().get_parent().get_parent().get_node("player").position.x - (position.x+get_parent().get_parent().get_parent() .position.x)) < 500 and abs(get_parent().get_parent().get_parent().get_parent().get_node("player").position.y - (position.y+get_parent().position.y+get_parent().get_parent().get_parent().position.y)) < 100 and !atack:
			
			if find_vel:
	
				$move_timer.stop()
				move = true
			
				if get_parent().get_parent().get_parent().get_parent().get_node("player").position.x - (position.x+get_parent().get_parent().get_parent().position.x) < 0:
						
					speed = -200
					$Area2D/CollisionShape2D.position.x = -35
					$sprite_m.flip_h = false
						
				else:
						
					$sprite_m.flip_h = true
					$Area2D/CollisionShape2D.position.x = 35
					speed = 200	
					
					find_vel = false
				
		elif move and !atack:

			move = false
			find_vel = true
			
			if randi()%2 == 1:
			
				speed = -200
				$Area2D/CollisionShape2D.position.x = -35
				$sprite_m.flip_h = false
				
			else:
				
				$sprite_m.flip_h = true
				$Area2D/CollisionShape2D.position.x = 35
				speed = 200
				
			$move_timer.wait_time = randi()%2 + 2
			$move_timer.start()
			
		position.x += speed * delta
		position.y -= gravity_f * delta
		
	move_and_slide(Vector2(0,0))
	
func jump():			# Функция прыжка

	for x in range(20):			# Вверх 

		gravity_f = 400 - (x)*(x)
		yield(get_tree().create_timer(0.01),"timeout")
	
	for x in range(20):		# Вниз

		gravity_f = -400 + (20-x)*(20-x)
		yield(get_tree().create_timer(0.01),"timeout")	
		
	was_jump = false
	
func die():
	
	get_parent().get_parent().get_parent().get_parent().mobs_count -= 1
	queue_free()

func _on_move_timer_timeout():
	move = true

func _on_Area2D_body_entered(body):
	
	if body.get_child(0).name != 'sprite_m':
		
		if !was_jump:
			was_jump = true
			jump()

func _on_Area2D_area_entered(area):
	
	if area.name == 'start' or area.get_child(0).name == 'obs':
		speed *= -1
			
		if $sprite_m.flip_h:
			$sprite_m.flip_h = false
			$Area2D/CollisionShape2D.position.x = 35
			
		else:
			$sprite_m.flip_h = true
			$Area2D/CollisionShape2D.position.x = -35

func _on_Area2D2_body_entered(body):
	
	if body.name == 'player' and !body.mobs_colide:

		body.xp -= 1
		atack = true
		body.mobs_colide = true
		body.was_atacked = true

func _on_Timer_timeout():
	atack = false
