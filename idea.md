# Projekt: Wood Mining Clicker

## Ročníkové téma
**Strategická hra obsahující systém**

## Nápad a koncept hry
Hra je koncipována jako strategická inkrementální (clicker) hra s prvky resource managementu, jejímž hlavním cílem je vybudování osady (království). Hráč začíná s prázdnýma rukama a musí efektivně spravovat a rozšiřovat svůj ekonomický aparát.

## Jak hra naplňuje zadaný "systém"?
Jádrem hry je **propojený ekonomický a konverzní systém**. Hráč v něm musí strategicky balancovat své zdroje a rozhodovat se, jak je investuje:
1. **Aktivní příjem:** Základní manuální těžba suroviny (dřeva) pomocí klikání.
2. **Pasivní příjem (Automatizace):** Systém nákupu pil, které generují suroviny automaticky v čase. Cena pil se po každém nákupu dynamicky zvyšuje (inflace), což hráče nutí strategicky plánovat návratnost investice.
3. **Konverze surovin:** Směna základní suroviny (dřevo) za vzácnou surovinu (kámen).

## Základní mechaniky a technické zpracování
* **Cíl hry:** Shromáždit 50 jednotek dřeva a 5 jednotek kamene pro slavnostní odhalení osady.
* **Dynamické UI:** Uživatelské rozhraní je přímo napojené na ekonomický systém. Tlačítka pro nákup nebo těžbu interaktivně reagují (zešednou/uzamknou se), pokud systém vyhodnotí nedostatek surovin.
* **Vizuální zpětná vazba:** Hra obsahuje matematicky počítaný Progress Bar, který vizualizuje celkový postup hráče směrem k vítězství na základě obou surovin.
* **UX a Quality of Life:** Integrované vyskakovací okno s nápovědou v hlavním menu a potvrzovací dialogy ve hře chránící hráče před nechtěným resetem nebo opuštěním rozehrané partie.
