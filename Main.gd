extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var patosnatela

var pato = preload("res://Pato.tscn")

var flyaway = 0
var catchs = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$duckgenerate.start()
	pass # Replace with function body.

func _process(delta):
	$HUD/Label.text = str(catchs)
	$Alvo.position.x=get_local_mouse_position().x
	$Alvo.position.y=get_local_mouse_position().y
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_duckgenerate_timeout():
	patosnatela = int(rand_range(1,6))
	for n in patosnatela:
		nasce()

		
func nasce():
	var novopato=pato.instance()
	add_child(novopato)
	novopato.position.x=rand_range(50,700)
	novopato.position.y=700


func _on_espera_timeout():
	$duckgenerate.start()
	pass # Replace with function body.


func _on_topo_body_entered(body):
	flyaway = 1
	patosnatela -=1
	$flyaway.play()
	atualizaturno()
	pass # Replace with function body.


func _on_chao_body_entered(body):
	catchs +=1
	patosnatela -=1
	$caiu.play()
	atualizaturno()
	body.queue_free()
	pass # Replace with function body.

func atualizaturno():
	print(patosnatela)
	if(patosnatela == 0):

		if flyaway == 1:
			$AnimationPlayer.play("rir")
			catchs=0
			$HUD/Label.text= str(catchs)
			$rir2.play()
		else:
			$AnimationPlayer.play("catch")
			
			$captura2.play()
	$espera.start()
