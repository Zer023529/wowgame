extends Node2D

var event: bool = false

func _ready():
	
	scale = get_viewport_rect().size/Vector2(1920,1080)
	$eventary.hide()
	
func _process(_delta):
	
	$player.event = event
	
	if Input.is_action_just_pressed("enventory"):
		
		event = true
		$eventary.show()
		$eventary/sword/CollisionShape2D.disabled = false
		$eventary/exit/CollisionShape2D.disabled = false
