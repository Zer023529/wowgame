extends Node2D

var can_atack: bool = false
var atack: bool = false

func _ready():
	$atack.hide()
	
func _process(_delta):
	
	if !get_parent().event:
		
		$Area2D/CollisionShape2D.position.x = $atack.position.x
		
		if get_parent().in_hand == 'sword':
		
			if Input.is_action_pressed("atack") and can_atack and !atack:
				
				$Area2D/CollisionShape2D.disabled = false
				$atack.show()
				$atack.play()
				
			if $atack.frame == 4:
				
				$atack.stop()
				$atack.frame = 0
				$atack.hide()
				atack = true
				$Timer.start()
				$Area2D/CollisionShape2D.disabled = true
				
		else:
			
			atack = false
			$Area2D/CollisionShape2D.disabled = true
			$atack.stop()
			$Timer.stop()

func _on_Timer_timeout():	
	atack = false
	$Area2D/CollisionShape2D.disabled = false

func _on_Area2D_area_entered(area):
	
	if area.get_child(0).name == 'mob':
		area.get_parent().die()
	
