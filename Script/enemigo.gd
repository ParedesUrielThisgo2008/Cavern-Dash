extends CharacterBody2D

@export var velocidad_patrulla: float = 600.0
@export var velocidad_persecucion: float = 1000.0
@export var distancia_patrulla: float = 9500.0
@export var distancia_ataque: float = 45.0
@export var tiempo_entre_ataques: float = 1.0
@export var daño: int = 1

@onready var rango = $RangoDeteccion

var jugador_objetivo: CharacterBody2D = null
var posicion_inicial: Vector2
var direccion_patrulla: float = 1.0
var tiempo_ataque: float = 0.0

func _ready():
	posicion_inicial = global_position
	rango.body_exited.connect(_al_perder)

func _physics_process(delta):
	if tiempo_ataque > 0.0:
		tiempo_ataque -= delta

	if jugador_objetivo == null:
		jugador_objetivo = null
		patrullar()
	else:
		perseguir()

	move_and_slide()

func patrullar():
	var limite_derecho = posicion_inicial.x + distancia_patrulla
	var limite_izquierdo = posicion_inicial.x - distancia_patrulla

	if global_position.x >= limite_derecho:
		direccion_patrulla = -1.0
	elif global_position.x <= limite_izquierdo:
		direccion_patrulla = 1.0

	velocity = Vector2(
		direccion_patrulla * velocidad_patrulla,
		0.0
	)

func perseguir():
	var diferencia = jugador_objetivo.global_position - global_position
	var distancia = diferencia.length()

	if distancia > distancia_ataque:
		velocity = diferencia.normalized() * velocidad_persecucion
	else:
		velocity = Vector2.ZERO
		atacar()

func atacar():
	if tiempo_ataque > 0.0:
		return

	if jugador_objetivo.has_method("recibir_daño"):
		jugador_objetivo.recibir_daño(daño)
		tiempo_ataque = tiempo_entre_ataques

func _al_perder(cuerpo):
	if cuerpo == jugador_objetivo:
		jugador_objetivo = null

func _on_rango_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador_objetivo = body
		
	Progreso.nivel_actual = get_tree().current_scene.scene_file_path
