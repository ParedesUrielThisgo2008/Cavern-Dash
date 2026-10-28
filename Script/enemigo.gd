extends CharacterBody2D

@export var velocidad_patrulla: float = 600.0
@export var velocidad_persecucion: float = 1000.0
@export var distancia_patrulla: float = 9500.0
@export var distancia_ataque: float = 45.0
@export var tiempo_entre_ataques: float = 1.0
@export var daño: int = 1
@export var radio_deteccion_nivel_2: float = 550.0

@onready var rango: Area2D = $RangoDeteccion
@onready var animacion: AnimatedSprite2D = $AnimatedSprite2D

var jugador_objetivo: CharacterBody2D = null
var posicion_inicial: Vector2
var direccion_patrulla: float = 1.0
var tiempo_ataque: float = 0.0

func _ready():
	posicion_inicial = global_position
	rango.body_exited.connect(_al_perder)

	if get_tree().current_scene.scene_file_path == "res://Scenes/Levels/Nivel_1.tscn":
		velocidad_patrulla = 900.0
		velocidad_persecucion = 1300.0
		distancia_patrulla = 2500.0

	if get_tree().current_scene.scene_file_path == "res://Scenes/Levels/Nivel_2.tscn":
		velocidad_patrulla = 1000.0
		velocidad_persecucion = 1300.0
		distancia_patrulla = 2500.0
		reducir_rango_nivel_2()

	cambiar_animacion("patrullar")
	
func reducir_rango_nivel_2():
	var forma = rango.get_node_or_null("CollisionShape2D")

	if forma == null or forma.shape == null:
		push_warning("No se encontró la forma de RangoDeteccion.")
		return

	if forma.shape is CircleShape2D:
		forma.shape = forma.shape.duplicate()
		forma.shape.radius = radio_deteccion_nivel_2
	else:
		push_warning("El rango de detección no utiliza CircleShape2D.")

func _physics_process(delta):
	if tiempo_ataque > 0.0:
		tiempo_ataque -= delta

	if not is_instance_valid(jugador_objetivo):
		jugador_objetivo = null
		patrullar()
	else:
		perseguir()

	move_and_slide()

func patrullar():
	cambiar_animacion("patrullar")

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

	actualizar_direccion(direccion_patrulla)

func perseguir():
	var diferencia = jugador_objetivo.global_position - global_position
	var distancia = diferencia.length()

	if distancia > distancia_ataque:
		cambiar_animacion("perseguir")

		if distancia > 0.0:
			velocity = diferencia.normalized() * velocidad_persecucion

		actualizar_direccion(diferencia.x)
	else:
		velocity = Vector2.ZERO
		atacar()

func atacar():
	cambiar_animacion("atacar")

	if tiempo_ataque > 0.0:
		return

	if is_instance_valid(jugador_objetivo):
		if jugador_objetivo.has_method("recibir_daño"):
			jugador_objetivo.recibir_daño(daño)
			tiempo_ataque = tiempo_entre_ataques

func cambiar_animacion(nombre: String):
	if animacion.animation != nombre:
		animacion.play(nombre)

func actualizar_direccion(direccion: float):
	if direccion != 0.0:
		animacion.flip_h = direccion < 0.0

func _al_perder(cuerpo):
	if cuerpo == jugador_objetivo:
		jugador_objetivo = null

func _on_rango_deteccion_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		jugador_objetivo = body as CharacterBody2D

	Progreso.nivel_actual = get_tree().current_scene.scene_file_path
