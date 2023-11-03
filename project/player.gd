extends Sprite2D

@export  var speed=250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x=405
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse=get_global_mouse_position()
	position.x=mouse.x
	
	if position.x >722:
		position.x=715
	if position.x<277:
		position.x=277
	
