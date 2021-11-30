extends Node2D

var b1: int = 0
var b2: int = 0
var b3: int = 0
var b4: int = 0
var q3: bool = false

func _process(_delta):
	
	if Input.is_action_just_pressed("mous_l"):
		
		if b1 == 1:
			b1 = 2
		elif b2 == 1:
			b2 = 2
		elif b3 == 1:
			b3 = 2
		elif b4 == 1:
			b4 = 2
			
	if b1 == 2:
		
		q3 = false
		b2 = 0
		b3 = 0
		b4 = 0
		$"Pixil-frame-0(11)2".show()
		$"Pixil-frame-0(11)3".show()
		$"Pixil-frame-0(11)".hide()
		$"Pixil-frame-0(11)4".show()
		
	elif b2 == 2:
		
		q3 = false
		b1 = 0
		b3 = 0
		b4 = 0
		$"Pixil-frame-0(11)2".hide()
		$"Pixil-frame-0(11)3".show()
		$"Pixil-frame-0(11)".show()
		$"Pixil-frame-0(11)4".show()
		
	elif b3 == 2:
		
		q3 = true
		b1 = 0
		b2 = 0
		b4 = 0
		$"Pixil-frame-0(11)2".show()
		$"Pixil-frame-0(11)3".hide()
		$"Pixil-frame-0(11)".show()
		$"Pixil-frame-0(11)4".show()
		
	elif b4 == 2:
		
		q3 = false
		b1 = 0
		b2 = 0
		b3 = 0
		$"Pixil-frame-0(11)2".show()
		$"Pixil-frame-0(11)3".show()
		$"Pixil-frame-0(11)".show()
		$"Pixil-frame-0(11)4".hide()
		
func _on_Area2D_mouse_entered():
	b1 = 1

func _on_Area2D_mouse_exited():
	b1 = 0

func _on_Area2D2_mouse_entered():
	b2 = 1

func _on_Area2D2_mouse_exited():
	b2 = 0

func _on_Area2D3_mouse_entered():
	b3 = 1

func _on_Area2D3_mouse_exited():
	b3 = 0

func _on_Area2D4_mouse_entered():
	b4 = 1

func _on_Area2D4_mouse_exited():
	b4 = 0
