extends Control

var drevo: int = 0
var kamen: int = 0
var pocet_pil: int = 0
var cena_pily: int = 5 # Necháváme rychlé ceny!

func _ready() -> void:
	$OsadaObrazek.visible = false
	$BtnZpetDoMenu.visible = false # Skryjeme tlačítko návratu
	
	$BtnTezitDrevo.pressed.connect(_on_tezit_drevo)
	$BtnKoupitPilu.pressed.connect(_on_koupit_pilu)
	$BtnTezitKamen.pressed.connect(_on_tezit_kamen)
	$BtnPostavitOsadu.pressed.connect(_on_postavit_osadu)
	$CasovacTezby.timeout.connect(_on_casovac_timeout)
	
	# Propojení nového tlačítka
	$BtnZpetDoMenu.pressed.connect(_on_btn_zpet_do_menu_pressed)
	
	aktualizuj_ui()

func aktualizuj_ui() -> void:
	$DrevoLabel.text = "Dřevo: " + str(drevo)
	$KamenLabel.text = "Kámen: " + str(kamen)
	$BtnKoupitPilu.text = "Koupit pilu\n(Cena: " + str(cena_pily) + " dřeva)"
	
	if drevo >= 10 and kamen >= 3:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Máš vše připraveno!)"
	else:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Potřebuješ 10 dřeva, 3 kameny)"

func _on_tezit_drevo() -> void:
	drevo += 1
	aktualizuj_ui()

func _on_koupit_pilu() -> void:
	if drevo >= cena_pily:
		drevo -= cena_pily
		pocet_pil += 1
		cena_pily += 2
		aktualizuj_ui()

func _on_tezit_kamen() -> void:
	if drevo >= 2: 
		drevo -= 2
		kamen += 1
		aktualizuj_ui()

func _on_postavit_osadu() -> void:
	if drevo >= 10 and kamen >= 3:
		drevo -= 10
		kamen -= 3
		
		$OsadaObrazek.visible = true 
		$BtnZpetDoMenu.visible = true # Ukáže se tlačítko pro návrat
		
		$BtnPostavitOsadu.text = "VÍTĚZSTVÍ!\nKrálovství je postaveno."
		$BtnPostavitOsadu.disabled = true 
		$CasovacTezby.stop() 
		
		aktualizuj_ui()

func _on_casovac_timeout() -> void:
	if pocet_pil > 0:
		drevo += pocet_pil
		aktualizuj_ui()

# Funkce, která tě hodí zpět
func _on_btn_zpet_do_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
