---
titel: "Template Klassenarbeit: Loesung, Bewertung, Erwartungshorizont"
klasse: "BG12"
fach: "Informatik"
bearbeitungszeit: "60 Minuten"
erreichbare_punkte: 34
profil: "lehrkraft"
---

# Template: Lehrkraftfassung mit Loesungen und Erwartungshorizont

## Zweck

Diese Vorlage erweitert die reine Aufgabenstellung um:
- Musterloesungen
- Erwartungshorizont
- Bewertungsraster
- typische Fehlleistungen und Teilpunkte

## Didaktische Pflichtregel

- Teil B (Modellierung) und Teil C (SQL) sind unterschiedliche Kontexte.
- Teil C basiert auf einer separaten 3NF-Datenbank mit eigenem Dump und eigenem Modell.

## Artefakte (Pflicht)

1. `generated/klassenarbeiten/KAxx_..._schema_data_dump.sql`
2. `generated/klassenarbeiten/KAxx_..._SQLDB_EERM.mwb`
3. `generated/klassenarbeiten/KAxx_..._SQLDB_EERM.png` (Workbench-Export oder Generator)

```markdown
![EERM Teil C - Bewertungsgrundlage](../../../generated/klassenarbeiten/KAxx_..._SQLDB_EERM.png)
```

## Teil A: Theorie (3 Punkte)

### Aufgabe A1
[Aufgabenstellung aus Schuelervorlage]

### Musterloesung
- Aussage 1: richtig
- Aussage 2: falsch
- Aussage 3: richtig
- Aussage 4: falsch
- Aussage 5: richtig
- Aussage 6: falsch

### Erwartungshorizont
- Fachbegriffe korrekt zuordnen
- Integritaet und 3NF konzeptionell verstanden

### Bewertung
- 0,5 Punkte pro korrekter Aussage
- keine Negativpunkte

## Teil B: Modellierung/Normalisierung (14 Punkte)

### Sachverhalt B (Kontext 1)
[Ausformulierte Modellierungsdomaene]

### Aufgabe B1 (8 Punkte): EERM
#### Musterloesung
- Entitaeten und Beziehungen vollstaendig
- Schluessel konsistent gesetzt
- N:M-Beziehung korrekt ueber Zwischentabelle aufgeloest

#### Erwartungshorizont
- Modell fachlich konsistent
- Kardinalitaeten fachlich plausibel
- Attributwahl begruendet

#### Bewertungsraster
- 3,0 Punkte: Entitaeten/Attribute
- 3,0 Punkte: Beziehungen/Kardinalitaeten
- 2,0 Punkte: Schluessel/FKs

### Aufgabe B2 (4 Punkte): 3NF-Begruendung
#### Musterloesung
- funktionale Abhaengigkeiten je Relation benannt
- keine partiellen und transitive Abhaengigkeiten

#### Erwartungshorizont
- Begruendung ist nachvollziehbar und korrekt terminiert

#### Bewertungsraster
- 2,0 Punkte: korrekte Abhaengigkeiten
- 2,0 Punkte: korrekte 3NF-Argumentation

### Aufgabe B3 (2 Punkte): Anomalien
#### Musterloesung
- Einfuegeanomalie: ...
- Aenderungsanomalie: ...
- Loeschanomalie: ...

#### Erwartungshorizont
- Mindestens zwei Anomalien mit passendem Beispiel

#### Bewertung
- 1,0 Punkt je korrekter Anomalie mit Beispiel

## Teil C: SQL-Abfragen (14 Punkte)

### Sachverhalt C (Kontext 2, separater SQL-Kontext)
[Ausformulierte SQL-Domaene mit Verweis auf Dump und Modell]

### Aufgabe C1 (4 Punkte)
#### Musterloesung (Beispiel)
```sql
SELECT k.name, a.buchungsdatum, c.titel
FROM kunde k
JOIN buchung a ON a.kunde_id = k.kunde_id
JOIN angebot c ON c.angebot_id = a.angebot_id
JOIN standort s ON s.standort_id = c.standort_id
WHERE s.stadt = 'Stuttgart'
ORDER BY a.buchungsdatum DESC;
```

#### Erwartungshorizont
- korrekter JOIN-Pfad
- korrekter Filter
- nachvollziehbare Sortierung

#### Bewertungsraster
- 1,5 Punkte: korrekte JOINs
- 1,0 Punkte: korrekter Filter
- 0,5 Punkte: korrekte Sortierung
- 1,0 Punkt: syntaktische Korrektheit

### Aufgabe C2 (4 Punkte)
#### Musterloesung (Schema)
```sql
SELECT c.angebot_id, COUNT(*) AS anzahl
FROM buchung b
JOIN angebot c ON c.angebot_id = b.angebot_id
GROUP BY c.angebot_id
HAVING COUNT(*) >= 3;
```

#### Erwartungshorizont
- sinnvolle Gruppierung
- Aggregat korrekt eingesetzt
- HAVING korrekt angewendet

### Aufgabe C3 (3 Punkte)
#### Musterloesung
- Unterabfrage oder CTE ist fachlich korrekt und liefert Top-N/letzte Aktivitaet.

### Aufgabe C4 (3 Punkte)
#### Musterloesung
- LEFT JOIN zeigt fehlende Beziehungen (NULL-Seite) korrekt.

## Teil D: Grundlagen Programmierung (3 Punkte)

### Aufgabe D1: Struktogramm
#### Musterloesung
- Eingabe in erlaubtem Bereich
- Schleife bis gueltige Eingabe
- Bedingte Ausgabe

#### Erwartungshorizont
- Kontrollstrukturen korrekt
- Darstellung lesbar

#### Bewertungsraster
- 1,5 Punkte: Logik
- 1,0 Punkt: Struktur
- 0,5 Punkte: Notation/Lesbarkeit

## Typische Fehlleistungen und Teilpunkte

- JOIN-Bedingung fehlt: max. 50% der C1-Punkte
- WHERE statt HAVING bei Aggregat: 1 Punkt Abzug in C2
- 3NF nur behauptet, nicht begruendet: max. 50% der B2-Punkte
- Struktogramm ohne Schleife: max. 1,5 Punkte in D1

## Freigabecheck vor Einsatz

- Kontexte B und C sind unterschiedlich
- SQL-Dump passt zum Erwartungshorizont
- Modell-PNG ist vorhanden/eingebettet
- Punkte summieren sich auf 34
- Bewertungsraster ist transparent und konsistent
