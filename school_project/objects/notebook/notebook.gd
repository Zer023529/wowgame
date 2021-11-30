extends Node2D

var r: int = 0

var mous_exit: bool = false

func _ready():
	
	hide()
	$r1.hide()
	$r2.hide()
	$r3.hide()
	$r4.hide()
	$r5.hide()
	$Area2D/CollisionShape2D.disabled = true

func _process(_delta):
	
	if mous_exit:
		
		if Input.is_action_just_pressed("mous_l"):
			
			$Area2D/CollisionShape2D.disabled = true
			hide()
			
			get_parent().get_node('eventary/sword/CollisionShape2D').disabled = false
			get_parent().get_node('eventary/exit/CollisionShape2D').disabled = false
			get_parent().get_node('eventary/book/CollisionShape2D').disabled = false
			
	if r == 1:
		$r1.show()
	elif r == 2:
		$r2.show()	
	elif r == 3:
		$r3.show()
	elif r == 4:
		$r4.show()
	elif r == 5:
		$r5.show()

func _on_Area2D_mouse_entered():
	mous_exit = true

func _on_Area2D_mouse_exited():
	mous_exit = false
