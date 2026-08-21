extends Control

var drevo: int = 0
var kamen: int = 0
var pocet_pil: int = 0
var cena_pily: int = 5 # RYCHLÝ TEST: levnější pila

func _ready() -> void:
	$OsadaObrazek.visible = false
	
	$BtnTezitDrevo.pressed.connect(_on_tezit_drevo)
	$BtnKoupitPilu.pressed.connect(_on_koupit_pilu)
	$BtnTezitKamen.pressed.connect(_on_tezit_kamen)
	$BtnPostavitOsadu.pressed.connect(_on_postavit_osadu)
	$CasovacTezby.timeout.connect(_on_casovac_timeout)
	
	aktualizuj_ui()

func aktualizuj_ui() -> void:
	$DrevoLabel.text = "Dřevo: " + str(drevo)
	$KamenLabel.text = "Kámen: " + str(kamen)
	$BtnKoupitPilu.text = "Koupit pilu\n(Cena: " + str(cena_pily) + " dřeva)"
	
	# RYCHLÝ TEST: Změněny texty podmínek
	if drevo >= 10 and kamen >= 3:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Máš vše připraveno!)"
	else:
		$BtnPostavitOsadu.text = "Postavit osadu\n(Potřebuješ 10 dřeva, 3 kameny)"

func _on_tezit_drevo() -> void:
	# Můžeš sem dát i drevo += 5, pokud bys to chtěl ještě rychlejší :)
	drevo += 1
	aktualizuj_ui()

func _on_koupit_pilu() -> void:
	if drevo >= cena_pily:
		drevo -= cena_pily
		pocet_pil += 1
		cena_pily += 2 # RYCHLÝ TEST: menší zdražování
		aktualizuj_ui()

func _on_tezit_kamen() -> void:
	# RYCHLÝ TEST: Kámen stojí jen 2 dřeva
	if drevo >= 2: 
		drevo -= 2
		kamen += 1
		aktualizuj_ui()

func _on_postavit_osadu() -> void:
	# RYCHLÝ TEST: Stačí 10 dřeva a 3 kameny pro výhru
	if drevo >= 10 and kamen >= 3:
		drevo -= 10
		kamen -= 3
		
		$OsadaObrazek.visible = true 
		
		$BtnPostavitOsadu.text = "VÍTĚZSTVÍ!\nKrálovství je postaveno."
		$BtnPostavitOsadu.disabled = true 
		$CasovacTezby.stop() 
		
		aktualizuj_ui()

func _on_casovac_timeout() -> void:
	if pocet_pil > 0:
		drevo += pocet_pil
		aktualizuj_ui()
