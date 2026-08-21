extends Control

var drevo: int = 0
var kamen: int = 0
var pocet_pil: int = 0
var cena_pily: int = 10 
var hra_vyhrana: bool = false 

# NOVINKA: Paměť pro naše vyskakovací okno
var akce_k_potvrzeni: String = "" 

func _ready() -> void:
	$OsadaObrazek.visible = false
	$PotvrzeniPanel.visible = false # Skryjeme okno s dotazem
	
	# Smazali jsme skrývání tlačítka Zpět do menu, teď už je tam natrvalo
	
	$BtnTezitDrevo.pressed.connect(_on_tezit_drevo)
	$BtnKoupitPilu.pressed.connect(_on_koupit_pilu)
	$BtnTezitKamen.pressed.connect(_on_tezit_kamen)
	$BtnPostavitOsadu.pressed.connect(_on_postavit_osadu)
	$CasovacTezby.timeout.connect(_on_casovac_timeout)
	
	$BtnZpetDoMenu.pressed.connect(_on_btn_zpet_do_menu_pressed)
	$BtnReset.pressed.connect(_on_btn_reset_pressed)
	
	# NOVINKA: Napojení tlačítek Ano a Ne uvnitř panelu
	$PotvrzeniPanel/BtnAno.pressed.connect(_on_btn_ano_pressed)
	$PotvrzeniPanel/BtnNe.pressed.connect(_on_btn_ne_pressed)
	
	aktualizuj_ui()

func aktualizuj_ui() -> void:
	if hra_vyhrana:
		return 

	$DrevoLabel.text = "Dřevo: " + str(drevo)
	$KamenLabel.text = "Kámen: " + str(kamen)
	$BtnKoupitPilu.text = "Koupit pilu (+2 dřeva/s)\n(Cena: " + str(cena_pily) + " dřeva)"
	
	var postup_drevo = min(float(drevo) / 50.0, 1.0)
	var postup_kamen = min(float(kamen) / 5.0, 1.0)
	var celkove_procento = ((postup_drevo + postup_kamen) / 2.0) * 100.0
	$UkazatelPokroku.value = celkove_procento

	if drevo >= cena_pily:
		$BtnKoupitPilu.disabled = false
	else:
		$BtnKoupitPilu.disabled = true
		
	if drevo >= 10:
		$BtnTezitKamen.text = "Těžit kámen\n(Cena: 10 dřeva)"
		$BtnTezitKamen.disabled = false
	else:
		$BtnTezitKamen.text = "Těžit kámen\n(Cena: 10 dřeva)"
		$BtnTezitKamen.disabled = true
		
	if drevo >= 50 and kamen >= 5:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Máš vše připraveno!)"
		$BtnPostavitOsadu.disabled = false
	else:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Potřebuješ 50 dřeva, 5 kamenů)"
		$BtnPostavitOsadu.disabled = true

func _on_tezit_drevo() -> void:
	drevo += 1
	$ZvukSekani.play() 
	aktualizuj_ui()

func _on_koupit_pilu() -> void:
	if drevo >= cena_pily:
		drevo -= cena_pily
		pocet_pil += 1
		cena_pily += 5
		aktualizuj_ui()

func _on_tezit_kamen() -> void:
	if drevo >= 10: 
		drevo -= 10
		kamen += 1
		aktualizuj_ui()

func _on_postavit_osadu() -> void:
	if drevo >= 50 and kamen >= 5:
		drevo -= 50
		kamen -= 5
		
		hra_vyhrana = true 
		
		$OsadaObrazek.visible = true 
		$UkazatelPokroku.value = 100.0
		
		$BtnPostavitOsadu.text = "VÍTĚZSTVÍ!\nKrálovství je postaveno."
		$BtnPostavitOsadu.disabled = true 
		$BtnTezitDrevo.disabled = true 
		$BtnKoupitPilu.disabled = true
		$BtnTezitKamen.disabled = true
		
		$CasovacTezby.stop() 

func _on_casovac_timeout() -> void:
	if pocet_pil > 0:
		drevo += (pocet_pil * 2)
		aktualizuj_ui()

# --- NOVINKA: LOGIKA POTVRZOVACÍHO OKNA ---

func _on_btn_zpet_do_menu_pressed() -> void:
	# Místo okamžitého odchodu jen ukážeme okno a nastavíme akci
	akce_k_potvrzeni = "menu"
	$PotvrzeniPanel/DotazLabel.text = "Opravdu chcete odejít do menu?\nZtratíte aktuální postup."
	$PotvrzeniPanel.visible = true

func _on_btn_reset_pressed() -> void:
	# Místo okamžitého resetu jen ukážeme okno a nastavíme akci
	akce_k_potvrzeni = "reset"
	$PotvrzeniPanel/DotazLabel.text = "Opravdu chcete začít znovu?\nVšechny suroviny budou ztraceny."
	$PotvrzeniPanel.visible = true

func _on_btn_ano_pressed() -> void:
	# Hráč klikl na ANO, vykonáme to, na co se ptal
	if akce_k_potvrzeni == "menu":
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	elif akce_k_potvrzeni == "reset":
		get_tree().reload_current_scene()

func _on_btn_ne_pressed() -> void:
	# Hráč klikl na NE, okno se jen schová a hraje se dál
	$PotvrzeniPanel.visible = false
