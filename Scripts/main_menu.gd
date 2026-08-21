extends Control

# Zkontroluj si, že se tvá herní scéna jmenuje přesně takto (pokud ne, uprav cestu)
const GAME_SCENE_PATH = "res://Scenes/hra.tscn"

func _ready() -> void:
	# Pojistka: Okno nápovědy je po spuštění schované
	$NapovedaPanel.visible = false
	
	# Propojení tlačítek
	$BtnStartGame.pressed.connect(_on_btn_start_game_pressed)
	$BtnNapoveda.pressed.connect(_on_btn_napoveda_pressed)
	$NapovedaPanel/BtnZavritNapovedu.pressed.connect(_on_btn_zavrit_napovedu_pressed)

# Funkce, která přepne z Menu do Hry
func _on_btn_start_game_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE_PATH)

# Funkce, která zobrazí nápovědu
func _on_btn_napoveda_pressed() -> void:
	$NapovedaPanel.visible = true

# Funkce, která schová nápovědu
func _on_btn_zavrit_napovedu_pressed() -> void:
	$NapovedaPanel.visible = false
