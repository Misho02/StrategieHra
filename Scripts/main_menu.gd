extends Control

const GAME_SCENE_PATH = "res://Scenes/hra.tscn"

func _ready() -> void:
	# Propojení signálu stisknutí tlačítka s naší funkcí
	$BtnStartGame.pressed.connect(_on_btn_start_game_pressed)

func _on_btn_start_game_pressed() -> void:
	# Bezpečné přepnutí stromu scén z Menu do Hry
	get_tree().change_scene_to_file(GAME_SCENE_PATH)
