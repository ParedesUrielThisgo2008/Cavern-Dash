extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	
	if body.is_in_group("jugador"):
		body.vida_actual = 0

		var interfaz = get_tree().get_first_node_in_group("interfaz_vida")
		if interfaz != null:
			interfaz.actualizar_vida(0)
		
	Progreso.nivel_actual = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file("res://Scenes/UI/game_over.tscn")
