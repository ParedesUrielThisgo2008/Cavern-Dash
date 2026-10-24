
extends Estado

@export var multiplicador_dash: float = 2.0

var direccion_dash: float = 1.0

func entrar():
	direccion_dash = jugador.ultima_direccion

func actualizar(delta: float):
	
	if Input.is_action_just_pressed("saltar"):
		if jugador.saltos_disponibles > 0:
			jugador.maquina_estados.cambiar_estado("saltar")
			return
	
	var tecla_presionada: bool

	if direccion_dash < 0.0:
		tecla_presionada = Input.is_action_pressed("izquierda")
	else:
		tecla_presionada = Input.is_action_pressed("derecha")

	if not tecla_presionada:
		jugador.velocity.x = 0.0

		if not jugador.is_on_floor():
			jugador.maquina_estados.cambiar_estado("caer")
		elif Input.get_axis("izquierda", "derecha") != 0.0:
			jugador.maquina_estados.cambiar_estado("caminar")
		else:
			jugador.maquina_estados.cambiar_estado("idle")
		return

	jugador.velocity.x = (
		direccion_dash
		* jugador.VELOCIDAD
		* multiplicador_dash
	)
