
extends Estado

var saltando_con_dash: bool = false
var direccion_salto: float = 1.0
var velocidad_dash: float = 0.0

func entrar():
	if jugador.saltos_disponibles <= 0:
		jugador.maquina_estados.cambiar_estado("caer")
		return

	# Comprobar si venimos del estado dash
	var estado_anterior = jugador.maquina_estados.estado_actual
	saltando_con_dash = (
		estado_anterior != null
		and estado_anterior.name.to_lower() == "dash"
	)

	if saltando_con_dash:
		direccion_salto = jugador.ultima_direccion
		velocidad_dash = jugador.velocity.x

	jugador.velocity.y = jugador.FUERZA_SALTO
	jugador.saltos_disponibles -= 1
	jugador.jump_buffer_timer = 0.0

func actualizar(delta: float):
	# Si estamos saltando con dash, conservar su impulso
	if saltando_con_dash:
		jugador.velocity.x = velocidad_dash
	else:
		var direccion = Input.get_axis("izquierda", "derecha")

		if direccion != 0.0:
			jugador.ultima_direccion = direccion

		jugador.velocity.x = direccion * jugador.VELOCIDAD

	if jugador.velocity.y >= 0.0:
		jugador.maquina_estados.cambiar_estado("caer")
