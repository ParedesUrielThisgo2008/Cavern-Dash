
class_name MaquinaEstados
extends Node

@export var estado_inicial: Estado

var estado_actual: Estado
var estados: Dictionary = {}

func _ready():
	for hijo in get_children():
		if hijo is Estado:
			estados[hijo.name.to_lower()] = hijo

func inicializar(jugador: CharacterBody2D):
	for hijo in get_children():
		if hijo is Estado:
			hijo.jugador = jugador

	if estado_inicial != null:
		cambiar_estado(estado_inicial.name.to_lower())
	else:
		push_warning("Asigná el estado inicial en el Inspector")

func actualizar_estado(delta: float):
	if estado_actual != null:
		estado_actual.actualizar(delta)

func cambiar_estado(nombre_nuevo_estado: String):
	var nombre = nombre_nuevo_estado.to_lower()
	var nuevo_estado = estados.get(nombre) as Estado

	if nuevo_estado == null:
		push_warning("No existe el estado: " + nombre)
		return

	if nuevo_estado == estado_actual:
		return

	if estado_actual != null:
		estado_actual.salir()

	estado_actual = nuevo_estado
	estado_actual.entrar()
