extends Area2D

@export var ruta_menu: String = "res://Scenes/UI/selector.tscn"
@export_enum("Ninguno", "Nivel1", "Nivel2", "Nivel3") 
var nivel_a_desbloquear: int = 0

var jugador_cerca: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D):
	if body.is_in_group("jugador"):
		jugador_cerca = true

func _on_body_exited(body: Node2D):
	if body.is_in_group("jugador"):
		jugador_cerca = false

func _process(_delta):
	if jugador_cerca and Input.is_action_just_pressed("entrar"):
		var interfaz = get_tree().get_first_node_in_group(
            "interfaz_coleccionables"
		)

		if interfaz == null:
			print("No se encontró la interfaz de coleccionables.")
			return

		if interfaz.llaves < 2:
			print("Necesitás las dos llaves para salir.")
			return

		if nivel_a_desbloquear == 1:
			Progreso.Nivel1_desbloqueado = true
		elif nivel_a_desbloquear == 2:
			Progreso.Nivel2_desbloqueado = true
		elif nivel_a_desbloquear == 3:
			Progreso.Nivel3_desbloqueado = true

		get_tree().change_scene_to_file(ruta_menu)
