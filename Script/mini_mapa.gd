
extends Control

@export var jugador: CharacterBody2D

@onready var vista_mapa = $VistaMapa
@onready var subviewport = $VistaMapa/SubViewport
@onready var camara = $VistaMapa/SubViewport/CamaraMinimapa
@onready var punto = $PuntoJugador

func _ready():
	subviewport.world_2d = get_viewport().world_2d
	subviewport.size = Vector2i(180, 120)
	
	camara.zoom = Vector2(0.1, 0.1)

	if jugador == null:
		push_warning("Minimapa: no asignaste el jugador en el Inspector.")

	if camara == null:
		push_warning("Minimapa: no se encontró CamaraMinimapa.")

func _process(_delta):
	if jugador == null or not is_instance_valid(jugador):
		return

	if camara == null or not is_instance_valid(camara):
		return

	camara.global_position = jugador.global_position
