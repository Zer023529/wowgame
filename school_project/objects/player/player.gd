extends KinematicBody2D

var speed_right: int = 250
var speed_left: int = 250
var speed_up: int = 250
var gravity_f: int = -500

var xp: int = 3
var shild: int = 0
var coin: int = 0

var can_jump: bool = false
var was_jump: bool = false
var on_ladder: bool = false
var ladder_up: bool = false
var ledder_bag: bool = false
var event: bool = false
var was_atacked: bool = false
var mobs_colide: bool = false

var in_hand = 'nothing'

onready var ladder_pos: int

func _ready():

	$sprite.play()
	$sword.hide()

func _physics_process(delta):
	
	if !event:
	
		get_parent().get_node("bar/xp").text = str(xp)
		get_parent().get_node("bar/shild").text = str(shild)
		get_parent().get_node("bar/coin").text = str(coin)
		
		if is_on_wall() and !was_jump:			# Если игрок на земле		
			gravity_f = 0
			
		else:
			
			if !was_jump:		# проверка на прыжок 
				gravity_f = -500
				
			$sprite.animation = 'stay'
			
			position.y -= gravity_f * delta
		
		if Input.is_action_pressed("ui_left") and speed_left != 0:		# Движение влево
			
			$sprite.animation = 'walk'
			$sprite.flip_h = true
			$sword/sword_img.flip_h = true
			$sword/sword_img.position.x = -8
			$sword/atack.flip_h = true
			$sword/atack.position.x = -35
			$Area2D/CollisionShape2D.position.x = -6
			get_parent().get_child(0).position.x += speed_left * delta

		elif Input.is_action_pressed("ui_right") and speed_right != 0:		# Движение вправо

			$sprite.animation = 'walk'
			$sprite.flip_h = false
			$sword/sword_img.flip_h = false
			$sword/sword_img.position.x = 8
			$sword/atack.flip_h = false
			$sword/atack.position.x = 30
			$Area2D/CollisionShape2D.position.x = 2
			get_parent().get_child(0).position.x -= speed_right * delta
			
		elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):				# Анимация стояния
			$sprite.animation = 'stay'
			
		if Input.is_action_just_pressed("ui_select") and is_on_wall() and !was_jump:				# Прыжок
			
			was_jump = true
			jump()
			
		elif Input.is_action_pressed("ui_up") and on_ladder and !ladder_up:		#Поднятие по лесенке вверх
			
			position.x = ladder_pos + get_parent().get_child(0).position.x
			position.y -= speed_up * delta

			speed_left = 0
			speed_right = 0
			
		elif Input.is_action_pressed("ui_down") and on_ladder:			#Спуск по лесенке
			
			position.x = ladder_pos + get_parent().get_child(0).position.x
			
			if !is_on_wall():
				
				position.y += speed_up * delta	
				speed_left = 0
				speed_right = 0
				
			else:
				ledder_bag = true
				
		if ledder_bag:			# Исправление бага с лесенкой
			if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
				
				speed_left = 250
				speed_right = 250
				ledder_bag = false
				
		if mobs_colide and was_atacked:
			damage()
				
		hand(in_hand)		
		
		move_and_slide(Vector2(0,0))		# Это не перемещает игрока, необходимо для работы is_on_wall()
			
func jump():			# Функция прыжка

	for x in range(20):			# Вверх 
		
		if on_ladder:
			gravity_f = 0
		else:
			gravity_f = 400 - (x)*(x)
			
		yield(get_tree().create_timer(0.01),"timeout")
	
	for x in range(20):		# Вниз

		if on_ladder:
			gravity_f = 0
		else:
			gravity_f = -400 + (20-x)*(20-x)
			
		yield(get_tree().create_timer(0.01),"timeout")	
		
	if !on_ladder:
		was_jump = false
		
func hand(thing):
	
	if thing == 'sword':
		$sword.show()
		$sword.can_atack = true
		
func damage():
	
	was_atacked = false
	if xp != 0:
		
		for _x in range(5):
			hide()
			yield(get_tree().create_timer(0.2), "timeout")
			show()
			yield(get_tree().create_timer(0.2), "timeout")
	
	else:
		die()
		
	mobs_colide = false

func die():
	
	get_parent().gg = true
	queue_free()
	
func _on_Area2D_body_entered(body):		#Столкновение с объектами сбоку
	
	if body.name != 'player':
	
		if $sprite.flip_h:
			speed_left = 0
		
		elif !$sprite.flip_h:
			speed_right = 0
			
		$sprite.animation = 'stay'

func _on_Area2D_body_exited(body):
	
	if body.name != 'player':
		speed_left = 250
		speed_right = 250

func _on_Area2D_area_entered(area):		#Если игрок в области лесницы
	
	if area.get_child(0).name == 'w':
		
		on_ladder = true
		was_jump = true
		gravity_f = 0
		
		ladder_pos = area.position.x
		
	elif area.get_child(0).name == 'room':
		
		area.get_child(0).queue_free()
		get_parent().room +=1
		
	elif area.get_child(0).name == 'l':
		
		speed_left = 0
		$sprite.animation = 'stay'
		
	elif area.get_child(0).name == 'r':
		
		speed_right = 0
		$sprite.animation = 'stay'
		
	elif area.get_child(0). name == 'heart':
		
		xp += 1
		area.queue_free()

func _on_Area2D_area_exited(area):		#Если игрок покидает область лесницы
	
	if area.get_child(0).name == 'w':
		on_ladder = false
		gravity_f = -500
	
		was_jump = false
		
	elif area.get_child(0).name == 'l':
		speed_left = 250
		
	elif area.get_child(0).name == 'r':
		speed_right = 250

func _on_Area2D2_area_exited(area):		# Если игрок поднялся выше лестникы

	if area.get_child(0).name == 'w':
		
		ladder_up = true
		speed_left = 250
		speed_right = 250

func _on_Area2D2_area_entered(area): 		# Если игрок вернулся 
	
	if area.get_child(0).name == 'w':
		ladder_up = false
