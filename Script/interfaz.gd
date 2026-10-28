extends CanvasLayer

@onready var instrucciones = $Instrucciones
@onready var instrucciones2 = $Instrucciones2
@onready var instrucciones3 = $Instrucciones3
@onready var instrucciones4 = $Instrucciones4

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
	
func _ready() -> void:
	if get_tree().current_scene.scene_file_path != "res://Scenes/Levels/Mundo.tscn":
		return
		
	instrucciones.show()
	instrucciones2.hide()
	instrucciones3.hide()
	instrucciones4.hide()
	
	await  get_tree().create_timer(4.0).timeout
	
	instrucciones.hide()
	
	await get_tree().create_timer(3.0).timeout
	
	instrucciones2.show()
	
	await get_tree().create_timer(6.0).timeout
	
	instrucciones2.hide()
	
	await  get_tree().create_timer(4.0).timeout
	
	instrucciones3.show()
	
	await get_tree().create_timer(3.0).timeout
	
	instrucciones3.hide()
	
	await get_tree().create_timer(3.0).timeout
	
	instrucciones4.show()
	
	await get_tree().create_timer(3.0).timeout
	
	instrucciones4.hide()
