
extends Control

@onready var BotonNivel1: Button = $VBoxContainer/HBoxContainer2/BotonNivel1
@onready var BotonNivel2: Button = $VBoxContainer/HBoxContainer2/BotonNivel2
@onready var BotonNivel3: Button = $VBoxContainer/HBoxContainer2/BotonNivel3

func _ready():
	BotonNivel1.disabled = not Progreso.Nivel1_desbloqueado
	BotonNivel2.disabled = not Progreso.Nivel2_desbloqueado
	BotonNivel3.disabled = not Progreso.Nivel3_desbloqueado

func _on_boton_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/menu_inicio.tscn")

func _on_boton_nivel_prueba_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/Mundo.tscn")

func _on_boton_nivel_1_pressed() -> void:
	if Progreso.Nivel1_desbloqueado:
		get_tree().change_scene_to_file("res://Scenes/Levels/Nivel_1.tscn")

func _on_boton_nivel_2_pressed() -> void:
	if Progreso.Nivel2_desbloqueado:
		get_tree().change_scene_to_file("res://Scenes/Levels/Nivel_2.tscn")

func _on_boton_nivel_3_pressed() -> void:
	if Progreso.Nivel3_desbloqueado:
		get_tree().change_scene_to_file("res://Scenes/Levels/Nivel_3.tscn")
