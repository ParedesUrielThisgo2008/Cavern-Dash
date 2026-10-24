extends Estado

const IMPULSO_PARED: float = 350.0

func entrar():
	# Impulso vertical
	jugador.velocity.y = jugador.FUERZA_SALTO

	# Impulso horizontal contrario a la pared
	var normal_pared = jugador.get_wall_normal()
	jugador.velocity.x = normal_pared.x * IMPULSO_PARED

func actualizar(delta: float):
	# No permitir que el movimiento normal cancele
	# el impulso horizontal del salto de pared.
	if jugador.velocity.y >= 0.0:
		jugador.maquina_estados.cambiar_estado("caer")
