# Informationsblatt Teil B: Redundanzen

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil B: Schulisches Lernlabor

## Lernziele
- Du erkennst redundante Datenstrukturen im Modell.
- Du erklärst Risiken von Redundanzen.
- Du reduzierst Redundanz durch sinnvolle Modellierung.

## Was ist Redundanz?
Redundanz bedeutet: dieselbe Information wird mehrfach gespeichert.

## Warum ist Redundanz problematisch?
- Mehr Speicherverbrauch.
- Höheres Fehlerrisiko bei Änderungen.
- Widersprüchliche Datenstände möglich.

## Beispiel aus dem Lernlabor
Ungünstig:
- In jeder TEILNAHME-Zeile stehen WorkshopTitel und LehrkraftName erneut.

Folge:
- Ändert sich ein Titel, müssen viele Zeilen geändert werden.

Besser:
- WORKSHOP(WorkshopID, Titel, LehrkraftID)
- LEHRKRAFT(LehrkraftID, Name)
- TEILNAHME(SchuelerID, WorkshopID)

So wird jede Information an genau einer Stelle gepflegt (Single Source of Truth).

## Redundanz und Anomalien
- Änderungsanomalie: Eine Änderung muss an vielen Stellen erfolgen.
- Einfügeanomalie: Neue Information kann nicht ohne andere Daten eingefügt werden.
- Löschanomalie: Beim Löschen gehen ungewollt weitere Informationen verloren.

## Merksätze
- Eine Tatsache, ein Speicherort.
- Wiederholung von Stammdaten ist ein Warnsignal.
- Gute Modelle trennen Stammdaten und Vorgangsdaten.

## Typische Fehler
- Namen statt IDs als Verbindung verwenden.
- Viele „bequeme“ Duplikate in Zwischentabellen.
- Redundanz als „normal“ akzeptieren.

## Mini-Check
- Welche Information taucht mehrfach auf?
- Kann diese Information in einen eigenen Entitätstyp ausgelagert werden?
- Sind Beziehungen über Schlüssel statt über Klartext modelliert?

## Begriffshilfe
- [Stichwortverzeichnis Relationale Datenbanken](../begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.md)
