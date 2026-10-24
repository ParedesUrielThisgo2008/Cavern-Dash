extends Camera2D

@export var suavidad = 5.0

func _ready():
	enabled = true

func _process(delta):
	
	var jugador = get_parent()

	global_position = global_position.lerp(
		jugador.position,
		suavidad * delta
	)
