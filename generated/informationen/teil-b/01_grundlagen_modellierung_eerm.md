# Informationsblatt Teil B: Grundlagen Modellierung (EERM)

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil B: Schulisches Lernlabor (anders als Teil C)

## Lernziele
- Du erklärst den Zweck von EERM in eigenen Worten.
- Du unterscheidest Entitätstyp, Attribut und Beziehungstyp sicher.
- Du modellierst einen einfachen Sachverhalt als EERM für MySQL Workbench.

## Warum EERM?
Ein EERM hilft dir, einen realen Sachverhalt sauber zu strukturieren, bevor Tabellen erstellt werden.  
Grundidee: Erst fachlich korrekt modellieren, dann technisch umsetzen.

## Zentrale Begriffe
- Entitätstyp: Ein Ding oder Objektbereich, über den Daten gespeichert werden.
- Attribut: Eine Eigenschaft eines Entitätstyps.
- Primärschlüssel (PK): Attribut, das jede Entität eindeutig identifiziert.
- Beziehungstyp: Verknüpfung zwischen Entitätstypen.

## Praktisches Beispiel aus eurem Kontext (Lernlabor)
Sachverhalt: In einem Lernlabor wählen Schülerinnen und Schüler Workshops.

- Entitätstyp SCHUELER: SchuelerID (PK), Vorname, Nachname, Jahrgang
- Entitätstyp WORKSHOP: WorkshopID (PK), Titel, Raum
- Beziehungstyp NIMMT_TEIL zwischen SCHUELER und WORKSHOP

Gedankengang:
- Ein Schüler kann mehrere Workshops wählen.
- Ein Workshop kann von mehreren Schülern besucht werden.
- Damit liegt fachlich eine m:n-Beziehung vor.

## Vorgehen in der Klassenarbeit (Teil B)
1. Aufgabenstellung markieren: Nomen als mögliche Entitätstypen.
2. Verben prüfen: mögliche Beziehungstypen.
3. Attribute ergänzen, dann Primärschlüssel festlegen.
4. Kardinalitäten begründen (nicht raten).
5. Ergebnis als EERM in MySQL Workbench zeichnen.

## Merksätze
- Fachlogik zuerst, Technik danach.
- Jeder Entitätstyp braucht einen eindeutigen Schlüssel.
- Beziehungen beschreiben immer einen fachlichen Zusammenhang.

## Typische Fehler
- Entitätstypen mit Attributen verwechseln.
- Beziehung als Attribut modellieren.
- Fehlender Primärschlüssel.

## Mini-Check vor Abgabe
- Sind alle Entitätstypen fachlich notwendig?
- Hat jeder Entitätstyp einen PK?
- Sind alle Beziehungen mit Kardinalitäten versehen?
- Ist das Modell konsistent und eindeutig lesbar?

## Begriffshilfe
- [Stichwortverzeichnis Relationale Datenbanken](../begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.md)
