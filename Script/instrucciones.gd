extends Label

@export var tiempo_visible: float = 5.0

func _ready():
	show()
	await get_tree().create_timer(tiempo_visible).timeout
	hide()
