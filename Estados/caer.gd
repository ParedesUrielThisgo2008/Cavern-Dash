
extends Estado

func entrar():
	jugador.reproducir_animacion("caer")

func actualizar(delta: float):
	if jugador.is_on_floor():
		if jugador.jump_buffer_timer > 0.0:
			jugador.maquina_estados.cambiar_estado("saltar")
		elif Input.is_action_pressed("agacharse"):
			jugador.maquina_estados.cambiar_estado("agacharse")
		elif Input.get_axis("izquierda", "derecha") != 0.0:
			jugador.maquina_estados.cambiar_estado("caminar")
		else:
			jugador.maquina_estados.cambiar_estado("idle")
		return

	# Salto de pared
	if jugador.is_on_wall() and jugador.jump_buffer_timer > 0.0:
		jugador.jump_buffer_timer = 0.0
		jugador.maquina_estados.cambiar_estado("salto_pared")
		return

	# Doble salto
	if (
		Input.is_action_just_pressed("saltar")
		and jugador.saltos_disponibles > 0
	):
		jugador.maquina_estados.cambiar_estado("saltar")
		return

	# Agacharse en el aire
	if Input.is_action_pressed("agacharse"):
		jugador.maquina_estados.cambiar_estado("agacharse")
		return

	var direccion = Input.get_axis("izquierda", "derecha")
	
	if direccion != 0:
		jugador.actualizar_direccion(direccion)

	if direccion != 0.0:
		jugador.ultima_direccion = direccion

	jugador.velocity.x = direccion * jugador.VELOCIDAD
