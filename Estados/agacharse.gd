
extends Estado

@export var velocidad_caida: float = 1200.0

func entrar():
	jugador.reproducir_animacion("caer_rapido")
	pass

func actualizar(delta: float):
	if not Input.is_action_pressed("agacharse"):
		if not jugador.is_on_floor():
			jugador.maquina_estados.cambiar_estado("caer")
		elif Input.get_axis("izquierda", "derecha") != 0.0:
			jugador.maquina_estados.cambiar_estado("caminar")
		else:
			jugador.maquina_estados.cambiar_estado("idle")
		return

	if not jugador.is_on_floor():
		jugador.velocity.y = maxf(
			jugador.velocity.y,
			velocidad_caida
		)

		var direccion = Input.get_axis("izquierda", "derecha")
		jugador.velocity.x = direccion * jugador.VELOCIDAD
		return

	jugador.velocity.x = 0.0

	if jugador.jump_buffer_timer > 0.0:
		jugador.maquina_estados.cambiar_estado("saltar")
