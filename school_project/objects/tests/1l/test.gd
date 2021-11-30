extends Node2D

var b1: int = 0

func _ready():
	
	hide()
	$Area2D/CollisionShape2D.disabled = true
	$q1/Area2D/CollisionShape2D.disabled = true
	$q1/Area2D2/CollisionShape2D.disabled = true
	$q1/Area2D3/CollisionShape2D.disabled = true
	$q2/Area2D/CollisionShape2D.disabled = true
	$q2/Area2D2/CollisionShape2D.disabled = true
	$q2/Area2D3/CollisionShape2D.disabled = true
	$q3/Area2D/CollisionShape2D.disabled = true
	$q3/Area2D2/CollisionShape2D.disabled = true
	$q3/Area2D3/CollisionShape2D.disabled = true
	$q3/Area2D4/CollisionShape2D.disabled = true

func _process(_delta):

	if Input.is_action_just_pressed("mous_l"):
		
		if b1 == 1:
			b1 = 2
			
	if b1 == 2:
		
		if $q1.q1 and $q2.q2 and $q3.q3:
			
			get_parent().pass_exam = 2
			queue_free()
			
		else:
			
			get_parent().pass_exam = 1
			hide()
			$Area2D/CollisionShape2D.disabled = true
			$q1/Area2D/CollisionShape2D.disabled = true
			$q1/Area2D2/CollisionShape2D.disabled = true
			$q1/Area2D3/CollisionShape2D.disabled = true
			$q2/Area2D/CollisionShape2D.disabled = true
			$q2/Area2D2/CollisionShape2D.disabled = true
			$q2/Area2D3/CollisionShape2D.disabled = true
			$q3/Area2D/CollisionShape2D.disabled = true
			$q3/Area2D2/CollisionShape2D.disabled = true
			$q3/Area2D3/CollisionShape2D.disabled = true
			$q3/Area2D4/CollisionShape2D.disabled = true
			
		get_parent().event = false
			
func _on_Area2D_mouse_entered():
	b1 = 1

func _on_Area2D_mouse_exited():
	b1 = 0
