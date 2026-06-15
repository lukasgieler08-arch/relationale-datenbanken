# Informationsblatt Teil B: Normalisierung bis zur 3. Normalform

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil B: Schulisches Lernlabor

## Lernziele
- Du erklärst 1NF, 2NF und 3NF verständlich.
- Du erkennst Verstöße gegen Normalformen.
- Du leitest ein verbessertes Modell bis 3NF ab.

## Warum normalisieren?
Normalisierung reduziert Redundanzen und verhindert Änderungs-, Einfüge- und Löschanomalien.

## 1. Normalform (1NF)
Regel: Alle Attributwerte sind atomar (nicht mehrteilig, keine Listen in einem Feld).

Falsch:
- SCHUELER( SchuelerID, Name, Workshops="SQL;Python" )

Richtig:
- SCHUELER( SchuelerID, Name )
- TEILNAHME( SchuelerID, WorkshopID )

## 2. Normalform (2NF)
Regel: Jedes Nichtschlüsselattribut hängt vollständig vom gesamten Primärschlüssel ab.

Typischer Fall bei zusammengesetztem Schlüssel:
- TEILNAHME( SchuelerID, WorkshopID, SchuelerName )

Problem:
- SchuelerName hängt nur von SchuelerID ab, nicht von (SchuelerID, WorkshopID).

Lösung:
- SchuelerName in SCHUELER auslagern.

## 3. Normalform (3NF)
Regel: Keine transitiven Abhängigkeiten von Nichtschlüsselattributen.

Beispiel:
- WORKSHOP( WorkshopID, RaumID, RaumBezeichnung )

Problem:
- RaumBezeichnung hängt über RaumID ab, nicht direkt über WorkshopID.

Lösung:
- RAUM( RaumID, RaumBezeichnung )
- WORKSHOP( WorkshopID, RaumID )

## Merksätze
- 1NF: Keine Listen im Feld.
- 2NF: Volle Abhängigkeit vom ganzen Schlüssel.
- 3NF: Keine indirekten Abhängigkeiten.

## Klassenarbeitsstrategie
1. Schlüssel bestimmen.
2. Abhängigkeiten prüfen.
3. Schrittweise zerlegen.
4. Fachliche Bedeutung jeder Tabelle prüfen.

## Typische Fehler
- 2NF ohne zusammengesetzten Schlüssel prüfen.
- 3NF mit 2NF verwechseln.
- Zu früh technisch denken statt fachlich.
