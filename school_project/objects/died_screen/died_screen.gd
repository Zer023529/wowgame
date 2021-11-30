extends Node2D

var again = false

func _process(_delta):
	
	if again:
		
		if Input.is_action_just_pressed("mous_l"):
			var a = load('res://Node2D.tscn')
			get_tree().change_scene_to(a)

func _on_Area2D_mouse_entered():
	again = true
	
func _on_Area2D_mouse_exited():
	again = false
