extends RigidBody2D
@export var NextMash:PackedScene
@export var GroupName="Mash0s"
@export var score=0
var is_check=false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GroupName)
func  isCheck():
	return is_check
func  setCheck():
	is_check=true

	
func jump_out():
#	var bottleCenter = Vector2(470,361)
#	var forceDirection = (position - bottleCenter).normalized()
#
#	var shootSpeed = 500.0
#	var shootForce = forceDirection * shootSpeed
#	#set_gravity_scale(0.0)
#	apply_central_impulse(shootForce)
	$CollisionShape2D.set_deferred("disabled",true)
	



func _on_body_entered(body: Node) -> void:
	
	if NextMash:
		if body.is_in_group(GroupName):
			if body.position>=position:
				if !body.isCheck():
						is_check=true
						body.setCheck()
						var pop_mash=NextMash.instantiate()
						var pop_pos=(body.position+position)/2
						pop_mash.position=pop_pos
						body.queue_free()
						
						get_parent().call_deferred("add_child",pop_mash)
						queue_free()
						get_parent().add_score(score) 


	if body.name=="Limit":
		get_parent().call_deferred("game_over")

