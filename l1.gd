extends Node2D

var event: bool = false
var gg: bool = false
var pass_exam: int = 0
var can_test = false

var mobs_count: int = 0
var room: int = -1

var r1: bool = false
var d1: bool = true
var r2: bool = false
var d2: bool = true
var r3: bool = false
var d3: bool = true
var r4: bool = false
var d4: bool = true
var r5: bool = false
var d5: bool = true

var a: bool = true


func _ready():
	
	scale = get_viewport_rect().size/Vector2(1920,1080)
	$eventary.hide()
	
func _process(_delta):
	
	if !gg:
		
		$bar/mobs.text = str(mobs_count)
		$player.event = event
	
		if Input.is_action_just_pressed("enventory"):
		
			event = true
			$eventary.show()
			$eventary/sword/CollisionShape2D.disabled = false
			$eventary/exit/CollisionShape2D.disabled = false
			$eventary/book/CollisionShape2D.disabled = false
			
	else:
		var b = load('res://objects/died_screen/died_screen.tscn')
		get_tree().change_scene_to(b)
		
	if room == 0 and !r1:
		
		mobs_count = 4
		
		for x in range(4):
			$levels_elements/mobs/r1.get_child(x).start = true
			
		r1 = true
		
	elif room == 1 and !r2:
		
		mobs_count = 5
		
		for x in range(5):
			$levels_elements/mobs/r2.get_child(x).start = true
			
		r2 = true
		
	elif room == 2 and !r3:
		
		mobs_count = 3
		
		for x in range(3):
			$levels_elements/mobs/r3.get_child(x).start = true
			
		r3 = true
		
	elif room == 3 and !r4:
		
		mobs_count = 4
		
		for x in range(4):
			$levels_elements/mobs/r4.get_child(x).start = true
			
		r4 = true
		
	elif room == 4 and !r5:
		
		mobs_count = 3
		
		for x in range(3):
			$levels_elements/mobs/r5.get_child(x).start = true
			
		r5 = true
		
	if mobs_count == 0:
		
		if room == 0 and d1:
			
			$levels_elements/limitations/room1.queue_free()
			$notebook.r = 1
			d1 = false
			
		elif room == 1 and d2:
			
			$levels_elements/limitations/room2.queue_free()
			$notebook.r = 2
			d2 = false
			
		elif room == 2 and d3:
			
			$levels_elements/limitations/room3.queue_free()
			$notebook.r = 3
			d3 = false
			
		elif room == 3 and d4:
			
			$levels_elements/limitations/room4.queue_free()
			$notebook.r = 4
			d4 = false
			
		elif room == 4 and d5:
			
			$levels_elements/limitations/room5.queue_free()
			$notebook.r = 5
			d5 = false
			
	if can_test and Input.is_action_just_pressed("test"):
		
		event = true
		
		$test.show()
		$test/Area2D/CollisionShape2D.disabled = false
		$test/q1/Area2D/CollisionShape2D.disabled = false
		$test/q1/Area2D2/CollisionShape2D.disabled = false
		$test/q1/Area2D3/CollisionShape2D.disabled = false
		$test/q2/Area2D/CollisionShape2D.disabled = false
		$test/q2/Area2D2/CollisionShape2D.disabled = false
		$test/q2/Area2D3/CollisionShape2D.disabled = false
		$test/q3/Area2D/CollisionShape2D.disabled = false
		$test/q3/Area2D2/CollisionShape2D.disabled = false
		$test/q3/Area2D3/CollisionShape2D.disabled = false
		$test/q3/Area2D4/CollisionShape2D.disabled = false
		
	if pass_exam == 2:
		
		$levels_elements/Label.text = 'Поздравляю, ты сдал экзамен'
		yield(get_tree().create_timer(5),"timeout")
		$levels_elements/Label.text = ''
		
	elif pass_exam == 1:
		
		$levels_elements/Label.text = 'Попробуй ещё раз'
		$player.xp -= 1
		pass_exam = 0
		yield(get_tree().create_timer(5),"timeout")
		$levels_elements/Label.text = ''
		
func _on_Area2D_body_entered(body):
	
	if pass_exam == 2 and body.name == 'player':
		get_tree().quit()

func _on_Area2D4_body_entered(body):
	
	if body.name == 'player':
		
		can_test = true
		
		if a:
			a = false
			$levels_elements/Label.text = 'Поздравляю, ты прощел 1 уровень!'
			yield(get_tree().create_timer(5),"timeout")
			$levels_elements/Label.text = 'Пройди небольшой тест, и я пропущу тебя'
			yield(get_tree().create_timer(5),"timeout")
			$levels_elements/Label.text = 'Повтори правила, когда будешь готов нажми клавишу F'
			yield(get_tree().create_timer(5),"timeout")
			$levels_elements/Label.text =''
		
func _on_Area2D4_body_exited(_body):
	can_test = false
