extends Control

func pause():
	get_tree().paused=!get_tree().paused
	visible=get_tree().paused
	
func _input(event):
	if event.is_action_pressed("pausa"):
		pause()

func _on_boton_continuar_pressed():
	pause()

func _on_boton_reiniciar_pressed():
	get_tree().paused=false
	get_tree().reload_current_scene()

func _on_boton_menu_principal_pressed():
	get_tree().paused=false
	get_tree().change_scene_to_file("res://Scenes/UI/menu_inicio.tscn")
