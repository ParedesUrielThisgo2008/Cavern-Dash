extends CanvasLayer

@onready var corazones = [
	$Corazones/Corazon1,
	$Corazones/Corazon2,
	$Corazones/Corazon3,
	$Corazones/Corazon4,
	$Corazones/Corazon5
]

func actualizar_vida(vida_actual: int):
	for i in range(corazones.size()):
		corazones[i].visible = i < vida_actual

func morir():
	get_tree().change_scene_to_file("res://Scenes/UI/game_over.tscn")
