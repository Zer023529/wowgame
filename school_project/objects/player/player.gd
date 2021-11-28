extends KinematicBody2D

var speed_right: int = 250
var speed_left: int = 250
var speed_up: int = 250
var gravity_f: int = -500

var can_jump: bool = false
var was_jump: bool = false
var on_ladder: bool = false

var foll = false

onready var X_VEL = position.x		# Постоянная  Х координата игрока

func _ready():

	$sprite.play()

func _physics_process(delta):
	
	if is_on_wall() and !was_jump:			# Если игрок на земле
		
		gravity_f = 0
		can_jump = true
		
	else:
		
		if !was_jump:										# проверка на прыжок 
			gravity_f = -500
			
		$sprite.animation = 'stay'
		can_jump = false
		
		position.y -= gravity_f * delta
	
	if Input.is_action_pressed("ui_left"):		# Движение влево
		
		$sprite.animation = 'walk'
		$sprite.flip_h = true
		get_parent().get_child(0).position.x += speed_left * delta

	elif Input.is_action_pressed("ui_right"):		# Движение вправо

		$sprite.animation = 'walk'
		$sprite.flip_h = false
		get_parent().get_child(0).position.x -= speed_right * delta
		
	elif Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_right"):				# Анимация стояния
		$sprite.animation = 'stay'
		
	if Input.is_action_just_pressed("ui_select") and can_jump:				# Прыжок
		
		was_jump = true
		jump()
		
	elif Input.is_action_pressed("ui_up"):
		
		position.y -= speed_up * delta
		
		speed_left = 0
		speed_right = 0
		
	elif Input.is_action_pressed("ui_down") and !is_on_wall():
		
		position.y += speed_up * delta
		
		speed_left = 0
		speed_right = 0
		
	move_and_slide(Vector2(0,0))		# Это не перемещает игрока, необходимо для работы is_on_wall()
		
func jump():			# Функция прыжка

	for x in range(20):			# Вверх 
		
		gravity_f = 400 - (x)*(x)
		yield(get_tree().create_timer(0.02),"timeout")
	
	for x in range(20):		# Вниз
		
		gravity_f = -400 + (20-x)*(20-x)
		yield(get_tree().create_timer(0.02),"timeout")	
		
	was_jump = false
	gravity_f = -500

func _on_Area2D_body_entered(body):
	
	if body.name != 'player':
	
		if $sprite.flip_h:
			speed_left = 0
		
		elif !$sprite.flip_h:
			speed_right = 0

func _on_Area2D_body_exited(body):
	
	if body.name != 'player':
		speed_left = 250
		speed_right = 250

func _on_Area2D_area_entered(area):
	
	if area.name == 'ladder':
		
		on_ladder = true
		gravity_f = 0


func _on_Area2D_area_exited(area):
	pass # Replace with function body.
