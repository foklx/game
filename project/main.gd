extends Node2D
@export var mash_scene:Array[PackedScene]
var nowIndex
var nextIndex = randi_range(0,3)
var totalscore=0
var setindex=-1
var min=0
var sec=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_image()
	#$AudioStreamPlayer.playing=true
	$score.text=str(totalscore)
var c=0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$selectmash.position=$player.position
	$selectmash.position.y=$player.position.y+70
	if !$Button.button_pressed:
		if Input.is_action_just_pressed("drop"):
			if $selectmash.visible:
				if !$GameOver.visible:
					drop()
					await get_tree().create_timer(0.5).timeout
					
					change_image()
		if Input.is_action_just_pressed("set"):
			if $selectmash.visible:
				if !$GameOver.visible:
					setm()
					await get_tree().create_timer(0.5).timeout

func  drop():
	var dropmash=mash_scene[nowIndex].instantiate()
	add_child(dropmash)
	dropmash.position=$selectmash.position
	$selectmash.hide()
func setm():
	if setindex>=0:
		var tmp=nowIndex
		nowIndex=setindex
		setindex=tmp
		var texture=load("res://image/mash/"+str(nowIndex)+".png")
		$selectmash.set_texture(texture)
		texture=load("res://image/mash/"+str(setindex)+".png")
		$set.set_texture(texture)
	else:
		setindex=nowIndex
		var texture=load("res://image/mash/"+str(setindex)+".png")
		$set.set_texture(texture)
		change_image()
func change_image():
	nowIndex=nextIndex
	nextIndex=randi_range(0,3)
	
	var texture=load("res://image/mash/"+str(nowIndex)+".png")
	$selectmash.set_texture(texture)
	$selectmash.show()
	
	texture=load("res://image/mash/"+str(nextIndex)+".png")
	$Nextmash.set_texture(texture)
func add_score(score):
	totalscore+=score
	$score.text=str(totalscore)

func game_over():
	$selectmash.hide()
	$GameOver.show()
	#$Limit.get_node("CollisionShape2D").set_deferred("disabled",true)
	$TIME.stop()


func _on_button_pressed() -> void:
	$selectmash.show()
	$GameOver.hide()
	#$Limit.get_node("CollisionShape2D").set_deferred("disabled",false)
	get_tree().call_group("Mashs","jump_out")
	$TIME.stop()
	min=0
	sec=0
	$TIME/Label.text=str(min)+":"+'0'+str(sec)
	totalscore=0
	setindex=-1
	$set.texture=ImageTexture.new()
	$score.text=str(totalscore)
	$TIME.start()
	c=0
	change_image()



func _on_on_pressed() -> void:
	$off.visible=true
	$on.visible=false
	$AudioStreamPlayer.playing=false

func _on_off_pressed() -> void:
	$on.visible=true
	$off.visible=false
	$AudioStreamPlayer.playing=true


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.playing=true



func _on_time_timeout() -> void:
	if sec>=59:
		min+=1
		sec=0
	else:
		sec+=1
	if sec<10:
		$TIME/Label.text=str(min)+":"+'0'+str(sec)
	else:
		$TIME/Label.text=str(min)+":"+str(sec)

	
func pop_particle(pos):
	$Particles_star.position=pos
	$Particles_star.set_deferred("emitting",true)





