# Informationsblatt Teil B: Referentielle Integrität

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil B: Schulisches Lernlabor

## Lernziele
- Du erklärst den Begriff referentielle Integrität korrekt.
- Du erkennst, wann Fremdschlüssel benötigt werden.
- Du beschreibst die Wirkung von Integritätsregeln.

## Grundidee
Referentielle Integrität bedeutet: Ein Fremdschlüsselwert muss auf einen existierenden Primärschlüssel verweisen (oder NULL sein, falls erlaubt).

## Beispiel aus dem Lernlabor
- SCHUELER(SchuelerID PK, Name)
- WORKSHOP(WorkshopID PK, Titel)
- TEILNAHME(TeilnahmeID PK, SchuelerID FK, WorkshopID FK)

Regel:
- Eine Teilnahme darf nur existieren, wenn der zugehörige Schüler und der zugehörige Workshop existieren.

## Warum ist das wichtig?
Ohne referentielle Integrität entstehen „verwaiste“ Datensätze.

Beispiel:
- In TEILNAHME steht WorkshopID=77, aber Workshop 77 existiert nicht.

Das führt zu fehlerhaften Auswertungen und unzuverlässigen Daten.

## Integritätsaktionen (fachlich verstehen)
- RESTRICT/NO ACTION: Löschen/Ändern wird verhindert, wenn Verweise existieren.
- CASCADE: Änderungen/Löschungen werden auf abhängige Datensätze übertragen.
- SET NULL: FK wird auf NULL gesetzt (nur wenn erlaubt).

## Merksätze
- Kein Fremdschlüssel ohne gültiges Ziel.
- Beziehungen brauchen technische Absicherung durch FK-Regeln.
- Datenqualität ist kein Zufall, sondern Regelwerk.

## Typische Fehler
- Fremdschlüssel vergessen.
- Datentypen von PK und FK passen nicht zusammen.
- Löschregeln ohne fachliche Begründung wählen.

## Klassenarbeitsfokus
Wenn ihr im EERM Beziehungen modelliert, denkt direkt mit:
- Wo liegt später der Fremdschlüssel?
- Welche Integritätsregel passt fachlich?

## Begriffshilfe
- [Stichwortverzeichnis Relationale Datenbanken](../begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.md)
