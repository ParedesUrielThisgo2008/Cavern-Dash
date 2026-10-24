
extends Control

var cristales: int = 0
var llaves: int = 0

const CRISTALES_MAXIMOS: int = 10
const LLAVES_MAXIMAS: int = 2

@onready var label_cristales: Label = $LabelCristales
@onready var label_llaves: Label = $LabelLlaves

func _ready():
	add_to_group("interfaz_coleccionables")
	actualizar_contadores()

func registrar(tipo: String):
	if tipo == "Cristal":
		cristales = mini(cristales + 1, CRISTALES_MAXIMOS)
	elif tipo == "Llave":
		llaves = mini(llaves + 1, LLAVES_MAXIMAS)

	actualizar_contadores()

func actualizar_contadores():
	label_cristales.text = "Cristales %d/%d" % [
		cristales, CRISTALES_MAXIMOS
	]
	label_llaves.text = "Llaves %d/%d" % [
		llaves, LLAVES_MAXIMAS
	]
