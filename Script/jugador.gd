extends CharacterBody2D

@onready var maquina_estados: MaquinaEstados = $MaquinaEstados
@onready var interfaz = get_tree().get_first_node_in_group("interfaz_vida")

const VELOCIDAD: float = 900.0
const GRAVEDAD: float = 1200.0
const FUERZA_SALTO: float = -900.0
const TIEMPO_JUMP_BUFFER: float = 0.15

var vida_maxima: int = 5
var vida_actual: int = 5

var saltos_disponibles: int = 2
const SALTOS_MAXIMOS: int = 2

var jump_buffer_timer: float = 0.0

var ultima_direccion: float = 1.0

# Detección de doble pulsación para el dash
var tiempo_doble_pulsacion: float = 0.3
var tiempo_ultima_pulsacion: float = 0.0
var ultima_tecla: String = ""

func _ready():
	maquina_estados.inicializar(self)

func _physics_process(delta: float):
	# Jump buffer
	if Input.is_action_just_pressed("saltar"):
		jump_buffer_timer = TIEMPO_JUMP_BUFFER
	else:
		jump_buffer_timer = maxf(
			0.0,
			jump_buffer_timer - delta
		)

	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVEDAD * delta

	# Detectar doble pulsación
	tiempo_ultima_pulsacion = maxf(
		0.0,
		tiempo_ultima_pulsacion - delta
	)
	detectar_dash()

	# Actualizar el estado actual
	maquina_estados.actualizar_estado(delta)

	# Ejecutar física una sola vez
	move_and_slide()

	# Restaurar saltos al aterrizar
	if is_on_floor():
		saltos_disponibles = SALTOS_MAXIMOS

func detectar_dash():
	var tecla_actual: String = ""

	if Input.is_action_just_pressed("izquierda"):
		tecla_actual = "izquierda"
	elif Input.is_action_just_pressed("derecha"):
		tecla_actual = "derecha"

	if tecla_actual == "":
		return

	if (
		tecla_actual == ultima_tecla
		and tiempo_ultima_pulsacion > 0.0
	):
		ultima_direccion = (
			-1.0 if tecla_actual == "izquierda" else 1.0
		)

		maquina_estados.cambiar_estado("dash")
		ultima_tecla = ""
		tiempo_ultima_pulsacion = 0.0
	else:
		ultima_tecla = tecla_actual
		tiempo_ultima_pulsacion = tiempo_doble_pulsacion

		ultima_direccion = (
			-1.0 if tecla_actual == "izquierda" else 1.0
		)

func recibir_daño(cantidad: int):
	vida_actual -= cantidad
	vida_actual = max(vida_actual, 0)

	if interfaz != null:
		interfaz.actualizar_vida(vida_actual)

	if vida_actual <= 0:
		interfaz.morir()

func morir():
	print("El jugador murió")

	var ruta = "res://Scenes/game_over.tscn"
	var error = get_tree().change_scene_to_file(ruta)

	if error != OK:
		print("Error al cambiar de escena: ", error)

	print("Resultado del cambio de escena: ", error)
