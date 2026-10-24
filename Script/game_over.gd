extends Control

func _on_salir_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/selector.tscn")

func _on_reintentar_pressed():
	if Progreso.nivel_actual != "":
		get_tree().change_scene_to_file(Progreso.nivel_actual)
