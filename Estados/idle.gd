
extends Estado

func entrar():
	jugador.reproducir_animacion("idle")
	jugador.velocity.x = 0.0

func actualizar(delta: float):
	var direccion = Input.get_axis("izquierda", "derecha")
	
	if direccion != 0:
		jugador.maquina_estados.cambiar_estado("caminar")
		return
	
	if not jugador.is_on_floor():
		jugador.maquina_estados.cambiar_estado("caer")
		return

	if jugador.jump_buffer_timer > 0.0:
		jugador.maquina_estados.cambiar_estado("saltar")
		return

	if Input.is_action_pressed("agacharse"):
		jugador.maquina_estados.cambiar_estado("agacharse")
		return
