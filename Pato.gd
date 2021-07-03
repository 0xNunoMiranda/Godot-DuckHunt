extends KinematicBody2D

var lado = 1
var velocidade = Vector2()
var speed = 100
var queda = 1

func _ready():
	randomize()
	$Timer.wait_time = rand_range(0.2,2)
	$movimento.wait_time = rand_range(0.4,2)
	$anima.wait_time = rand_range(0.6,1)
	
func _process(delta):
	#movimentacao horizontal
	position.x += speed *lado*delta
	
	#movimentacao vertical
	position.y -= 140*queda*delta
	
	#flip de animacao
	if lado < 0:
		$AnimatedSprite.flip_h=true
	else:
		$AnimatedSprite.flip_h=false
	




func _on_movimento_timeout():
	lado = lado*(-1)


func _on_anima_timeout():
	if $AnimatedSprite.animation == "cima":
		$AnimatedSprite.animation = "lado"
	elif $AnimatedSprite.animation == "lado":
		$AnimatedSprite.animation = "cima"

func mata():
	$AudioStreamPlayer.stop()
	$AnimatedSprite.animation = "morte"
	queda = -1
	lado = 0


func _on_Timer_timeout():
	$AudioStreamPlayer.play()
	pass # Replace with function body.
