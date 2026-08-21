extends Control

var drevo: int = 0
var kamen: int = 0
var pocet_pil: int = 0
var cena_pily: int = 10

func _ready():
	$BtnTezitDrevo.pressed.connect(_on_tezit_drevo)
	$BtnKoupitPilu.pressed.connect(_on_koupit_pilu)
	$BtnTezitKamen.pressed.connect(_on_tezit_kamen)
	$BtnPostavitOsadu.pressed.connect(_on_postavit_osadu)
	$CasovacTezby.timeout.connect(_on_casovac_timeout)
	
	aktualizuj_ui()

func aktualizuj_ui():
	$DrevoLabel.text = "Dřevo: " + str(drevo)
	$KamenLabel.text = "Kámen: " + str(kamen)
	$BtnKoupitPilu.text = "Koupit pilu\n(Cena: " + str(cena_pily) + " dřeva)"

func _on_tezit_drevo():
	drevo += 1
	aktualizuj_ui()

func _on_koupit_pilu():
	if drevo >= cena_pily:
		drevo -= cena_pily
		pocet_pil += 1
		cena_pily += 10
		aktualizuj_ui()

func _on_tezit_kamen():
	if drevo >= 50:
		drevo -= 50
		kamen += 1
		aktualizuj_ui()

func _on_postavit_osadu():
	if drevo >= 500 and kamen >= 500:
		drevo -= 500
		kamen -= 500
		$BtnPostavitOsadu.text = "VYHRÁL JSI HRU!"
		$CasovacTezby.stop()
		aktualizuj_ui()

func _on_casovac_timeout():
	if pocet_pil > 0:
		drevo += pocet_pil
		aktualizuj_ui()
