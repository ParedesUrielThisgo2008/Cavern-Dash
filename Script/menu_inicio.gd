extends Control


func _on_boton_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/selector.tscn")


func _on_boton_opciones_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/Opciones.tscn")


func _on_boton_salir_pressed() -> void:
	get_tree().quit()
