extends Node2D

var mous_sword: bool = false
var mous_exit: bool = false
var mous_book: bool = false

func _process(_delta):
	
	if Input.is_action_just_pressed("mous_l"):
		
		if mous_sword:	
			
			get_parent().get_node('player').in_hand = 'sword'
			$sword/CollisionShape2D.disabled = true
			$exit/CollisionShape2D.disabled = true
			$book/CollisionShape2D.disabled = true
			get_parent().event = false
			hide()
		
		if mous_exit:
			
			$sword/CollisionShape2D.disabled = true
			$exit/CollisionShape2D.disabled = true
			$book/CollisionShape2D.disabled = true
			get_parent().event = false
			hide()
			
		if mous_book:
			
			$sword/CollisionShape2D.disabled = true
			$exit/CollisionShape2D.disabled = true
			$book/CollisionShape2D.disabled = true
			get_parent().get_node('notebook').show()
			get_parent().get_node('notebook').get_node('Area2D/CollisionShape2D').disabled = false
			
			mous_book = false
		
func _on_sword_mouse_entered():
	mous_sword = true

func _on_sword_mouse_exited():
	mous_sword = false

func _on_Area2D2_mouse_entered():
	mous_exit = true

func _on_Area2D2_mouse_exited():
	mous_exit = false

func _on_book_mouse_entered():
	mous_book = true

func _on_book_mouse_exited():
	mous_book = false
