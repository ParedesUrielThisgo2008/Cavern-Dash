
extends Estado

func actualizar(delta: float):
	if not jugador.is_on_floor():
		jugador.maquina_estados.cambiar_estado("caer")
		return

	if jugador.jump_buffer_timer > 0.0:
		jugador.maquina_estados.cambiar_estado("saltar")
		return

	if Input.is_action_pressed("agacharse"):
		jugador.maquina_estados.cambiar_estado("agacharse")
		return

	var direccion = Input.get_axis("izquierda", "derecha")

	if direccion == 0.0:
		jugador.maquina_estados.cambiar_estado("idle")
		return

	jugador.ultima_direccion = direccion
	jugador.velocity.x = direccion * jugador.VELOCIDAD
