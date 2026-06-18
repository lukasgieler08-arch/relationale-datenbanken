# Informationsblatt Teil B: Kardinalitäten (Eine-Sätze, mengenmäßiger Zusammenhang)

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil B: Schulisches Lernlabor

## Lernziele
- Du formulierst Kardinalitäten als präzise Eine-Sätze.
- Du leitest aus Texten den mengenmäßigen Zusammenhang korrekt ab.
- Du überträgst Kardinalitäten sicher in ein EERM.

## Was bedeuten Kardinalitäten?
Kardinalitäten beschreiben, wie viele Entitäten einer Seite maximal/minimal mit Entitäten der anderen Seite verknüpft sind.

Häufige Fälle:
- 1:1
- 1:n
- m:n

## Eine-Sätze als Methode
Formuliere immer zwei Sätze, je Richtung einen:
- Von A nach B
- Von B nach A

### Beispiel aus dem Lernlabor
Entitätstypen: LEHRKRAFT und WORKSHOP

Eine-Sätze:
- Eine Lehrkraft betreut mehrere Workshops.
- Ein Workshop wird von genau einer Lehrkraft betreut.

Ergebnis: 1:n (LEHRKRAFT zu WORKSHOP)

## Mengenmäßiger Zusammenhang
Frage dich systematisch:
- Minimum: Muss eine Verknüpfung existieren? (0 oder 1)
- Maximum: Wie viele sind möglich? (1 oder n)

Beispiel:
- Ein Schüler kann 0 bis n Workshops besuchen.
- Ein Workshop hat 0 bis n Schüler.
=> m:n mit optionaler Teilnahme auf beiden Seiten.

## Merksätze
- Keine Kardinalität ohne begründenden Eine-Satz.
- Erst Sprache, dann Diagramm.
- Wenn „mehrere auf beiden Seiten“ gilt, ist es meist m:n.

## Typische Fehler
- Kardinalitäten „gefühlt“ statt begründet setzen.
- Mindest- und Maximalteil falsch lesen.
- Eine-Sätze nur in eine Richtung formulieren.

## Mini-Übung
Aussage: „Jeder Raum kann zu verschiedenen Zeiten von mehreren Workshops genutzt werden; jeder Workshop findet in genau einem Raum statt.“

Aufgabe:
1. Formuliere zwei Eine-Sätze.
2. Bestimme die Kardinalität.
3. Begründe kurz.

## Begriffshilfe
- [Stichwortverzeichnis Relationale Datenbanken](../begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.md)
