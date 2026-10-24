
extends Area2D

@export_enum("Cristal", "Llave")
var tipo: String = "Cristal"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if not body.is_in_group("jugador"):
		return

	var interfaz = get_tree().get_first_node_in_group(
		"interfaz_coleccionables"
	)

	if interfaz != null:
		interfaz.registrar(tipo)
		queue_free()
