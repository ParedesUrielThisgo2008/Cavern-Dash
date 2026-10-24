
extends Estado

func entrar():
	jugador.velocity.x = 0.0

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

	if Input.get_axis("izquierda", "derecha") != 0.0:
		jugador.maquina_estados.cambiar_estado("caminar")
