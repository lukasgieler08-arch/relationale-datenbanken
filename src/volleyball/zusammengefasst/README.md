# Klassenarbeit BG12 2025/2026 – Kompendium
## EERM, Normalisierung, SQL-Abfragen und Struktogramme (60 Minuten)

---

## Inhaltsverzeichnis

1. [Überblick und Struktur](#überblick-und-struktur)
2. [Teil A: Theorie (Multiple Choice)](#teil-a-theorie-multiple-choice)
3. [Teil B: EERM, Normalisierung und Anomalien](#teil-b-eerm-normalisierung-und-anomalien)
   - [Grundlagen Modellierung](#grundlagen-modellierung-eerm)
   - [Kardinalitäten und Eine-Sätze](#kardinalitäten-und-eine-sätze)
   - [Normalisierung bis 3NF](#normalisierung-bis-zur-3-normalform)
   - [Redundanzen und Anomalien](#redundanzen-und-anomalien)
   - [Referentielle Integrität](#referentielle-integrität)
   - [MySQL Workbench Workflow](#mysql-workbench-workflow)
   - [Hilfsmittel für Teil B](#hilfsmittel-für-teil-b)
4. [Teil C: SQL-Abfragen über mehrere Tabellen](#teil-c-sql-abfragen-über-mehrere-tabellen)
   - [SQL-Abfragen Grundlagen](#sql-abfragen-über-mehrere-tabellen)
   - [Selektion in SQL](#selektion-in-sql)
   - [Gruppierung in SQL](#gruppierung-in-sql)
   - [Datenbankschema Stadtfahrradverleih](#datenbankschema-stadtfahrradverleih)
   - [Hilfsmittel für Teil C](#hilfsmittel-für-teil-c)
5. [Teil D: Grundlagen Programmierung – Struktogramm](#teil-d-grundlagen-programmierung)
6. [Aufgabenstellung](#aufgabenstellung)
7. [Musterlösungen und Erwartungshorizont](#musterlösungen-und-erwartungshorizont)

---

## Überblick und Struktur

**Klasse/Kurs:** BG12 | **Schuljahr:** 2025/2026 | **Bearbeitungszeit:** 60 Minuten | **Erreichbare Punkte:** 34

| Teil | Inhalte | Punkte | Zeit |
|---|---|---:|---:|
| A | Theorie (MC) | 3 | 5 Min |
| B | EERM, Normalisierung, Anomalien | 14 | 25 Min |
| C | SQL-Abfragen über mehrere Tabellen | 14 | 25 Min |
| D | Grundlagen Programmierung (Struktogramm) | 3 | 5 Min |
| **Gesamt** |  | **34** | **60 Min** |

Diese Klassenarbeit verfolgt das Ziel, praktische Fähigkeiten in Datenbankmodellierung und SQL-Abfragen zu prüfen und zu vertiefen.

---

## Teil A: Theorie (Multiple Choice)

### Aufgabe 1: Theorie (Multiple Choice) – 3 Punkte
Markieren Sie richtig/falsch. (0,5 Punkte je Aussage)

| Nr. | Aussage | r/f |
|-----|---------|-----|
| 1 | Ein Fremdschlüssel darf mehrfach vorkommen. | |
| 2 | Eine N:M-Beziehung wird in relationalen Modellen direkt ohne Zwischentabelle gespeichert. | |
| 3 | Ein LEFT JOIN kann Datensätze ohne Partner auf der rechten Seite sichtbar machen. | |
| 4 | Die 3NF reduziert Redundanz und Anomalien. | |
| 5 | Ein Primärschlüssel darf NULL sein. | |
| 6 | HAVING filtert Gruppen nach GROUP BY. | |

**Musterlösung:** r, f, r, r, f, r

---

## Teil B: EERM, Normalisierung und Anomalien

### Grundlagen Modellierung (EERM)

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** Schulisches Lernlabor (anders als Teil C)

#### Lernziele
- Du erklärst den Zweck von EERM in eigenen Worten.
- Du unterscheidest Entitätstyp, Attribut und Beziehungstyp sicher.
- Du modellierst einen einfachen Sachverhalt als EERM für MySQL Workbench.

#### Warum EERM?
Ein EERM hilft dir, einen realen Sachverhalt sauber zu strukturieren, bevor Tabellen erstellt werden. Grundidee: Erst fachlich korrekt modellieren, dann technisch umsetzen.

#### Zentrale Begriffe
- **Entitätstyp:** Ein Ding oder Objektbereich, über den Daten gespeichert werden.
- **Attribut:** Eine Eigenschaft eines Entitätstyps.
- **Primärschlüssel (PK):** Attribut, das jede Entität eindeutig identifiziert.
- **Beziehungstyp:** Verknüpfung zwischen Entitätstypen.

#### Praktisches Beispiel aus dem Kontext (Lernlabor)
**Sachverhalt:** In einem Lernlabor wählen Schülerinnen und Schüler Workshops.

- **Entitätstyp SCHUELER:** SchuelerID (PK), Vorname, Nachname, Jahrgang
- **Entitätstyp WORKSHOP:** WorkshopID (PK), Titel, Raum
- **Beziehungstyp NIMMT_TEIL:** zwischen SCHUELER und WORKSHOP

**Gedankengang:**
- Ein Schüler kann mehrere Workshops wählen.
- Ein Workshop kann von mehreren Schülern besucht werden.
- Damit liegt fachlich eine m:n-Beziehung vor.

#### Vorgehen in der Klassenarbeit (Teil B)
1. Aufgabenstellung markieren: Nomen als mögliche Entitätstypen.
2. Verben prüfen: mögliche Beziehungstypen.
3. Attribute ergänzen, dann Primärschlüssel festlegen.
4. Kardinalitäten begründen (nicht raten).
5. Ergebnis als EERM in MySQL Workbench zeichnen.

#### Merksätze
- Fachlogik zuerst, Technik danach.
- Jeder Entitätstyp braucht einen eindeutigen Schlüssel.
- Beziehungen beschreiben immer einen fachlichen Zusammenhang.

#### Typische Fehler
- Entitätstypen mit Attributen verwechseln.
- Beziehung als Attribut modellieren.
- Fehlender Primärschlüssel.

#### Mini-Check vor Abgabe
- Sind alle Entitätstypen fachlich notwendig?
- Hat jeder Entitätstyp einen PK?
- Sind alle Beziehungen mit Kardinalitäten versehen?
- Ist das Modell konsistent und eindeutig lesbar?

---

### Kardinalitäten und Eine-Sätze

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** Schulisches Lernlabor

#### Lernziele
- Du formulierst Kardinalitäten als präzise Eine-Sätze.
- Du leitest aus Texten den mengenmäßigen Zusammenhang korrekt ab.
- Du überträgst Kardinalitäten sicher in ein EERM.

#### Was bedeuten Kardinalitäten?
Kardinalitäten beschreiben, wie viele Entitäten einer Seite maximal/minimal mit Entitäten der anderen Seite verknüpft sind.

**Häufige Fälle:**
- 1:1
- 1:n
- m:n

#### Eine-Sätze als Methode
Formuliere immer zwei Sätze, je Richtung einen:
- Von A nach B
- Von B nach A

##### Beispiel aus dem Lernlabor
Entitätstypen: LEHRKRAFT und WORKSHOP

**Eine-Sätze:**
- Eine Lehrkraft betreut mehrere Workshops.
- Ein Workshop wird von genau einer Lehrkraft betreut.

**Ergebnis:** 1:n (LEHRKRAFT zu WORKSHOP)

#### Mengenmäßiger Zusammenhang
Frage dich systematisch:
- **Minimum:** Muss eine Verknüpfung existieren? (0 oder 1)
- **Maximum:** Wie viele sind möglich? (1 oder n)

**Beispiel:**
- Ein Schüler kann 0 bis n Workshops besuchen.
- Ein Workshop hat 0 bis n Schüler.
- => m:n mit optionaler Teilnahme auf beiden Seiten.

#### Merksätze
- Keine Kardinalität ohne begründenden Eine-Satz.
- Erst Sprache, dann Diagramm.
- Wenn „mehrere auf beiden Seiten" gilt, ist es meist m:n.

#### Typische Fehler
- Kardinalitäten „gefühlt" statt begründet setzen.
- Mindest- und Maximalteil falsch lesen.
- Eine-Sätze nur in eine Richtung formulieren.

#### Mini-Übung
**Aussage:** „Jeder Raum kann zu verschiedenen Zeiten von mehreren Workshops genutzt werden; jeder Workshop findet in genau einem Raum statt."

**Aufgabe:**
1. Formuliere zwei Eine-Sätze.
2. Bestimme die Kardinalität.
3. Begründe kurz.

---

### Normalisierung bis zur 3. Normalform

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** Schulisches Lernlabor

#### Lernziele
- Du erklärst 1NF, 2NF und 3NF verständlich.
- Du erkennst Verstöße gegen Normalformen.
- Du leitest ein verbessertes Modell bis 3NF ab.

#### Warum normalisieren?
Normalisierung reduziert Redundanzen und verhindert Änderungs-, Einfüge- und Löschanomalien.

#### 1. Normalform (1NF)
**Regel:** Alle Attributwerte sind atomar (nicht mehrteilig, keine Listen in einem Feld).

**Falsch:**
```
SCHUELER( SchuelerID, Name, Workshops="SQL;Python" )
```

**Richtig:**
```
SCHUELER( SchuelerID, Name )
TEILNAHME( SchuelerID, WorkshopID )
```

#### 2. Normalform (2NF)
**Regel:** Jedes Nichtschlüsselattribut hängt vollständig vom gesamten Primärschlüssel ab.

**Typischer Fall bei zusammengesetztem Schlüssel:**
```
TEILNAHME( SchuelerID, WorkshopID, SchuelerName )
```

**Problem:**
- SchuelerName hängt nur von SchuelerID ab, nicht von (SchuelerID, WorkshopID).

**Lösung:**
- SchuelerName in SCHUELER auslagern.

#### 3. Normalform (3NF)
**Regel:** Keine transitiven Abhängigkeiten von Nichtschlüsselattributen.

**Beispiel:**
```
WORKSHOP( WorkshopID, RaumID, RaumBezeichnung )
```

**Problem:**
- RaumBezeichnung hängt über RaumID ab, nicht direkt über WorkshopID.

**Lösung:**
```
RAUM( RaumID, RaumBezeichnung )
WORKSHOP( WorkshopID, RaumID )
```

#### Merksätze
- **1NF:** Keine Listen im Feld.
- **2NF:** Volle Abhängigkeit vom ganzen Schlüssel.
- **3NF:** Keine indirekten Abhängigkeiten.

#### Klassenarbeitsstrategie
1. Schlüssel bestimmen.
2. Abhängigkeiten prüfen.
3. Schrittweise zerlegen.
4. Fachliche Bedeutung jeder Tabelle prüfen.

#### Typische Fehler
- 2NF ohne zusammengesetzten Schlüssel prüfen.
- 3NF mit 2NF verwechseln.
- Zu früh technisch denken statt fachlich.

---

### Redundanzen und Anomalien

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** Schulisches Lernlabor

#### Lernziele
- Du erkennst redundante Datenstrukturen im Modell.
- Du erklärst Risiken von Redundanzen.
- Du reduzierst Redundanz durch sinnvolle Modellierung.

#### Was ist Redundanz?
Redundanz bedeutet: dieselbe Information wird mehrfach gespeichert.

#### Warum ist Redundanz problematisch?
- Mehr Speicherverbrauch.
- Höheres Fehlerrisiko bei Änderungen.
- Widersprüchliche Datenstände möglich.

#### Beispiel aus dem Lernlabor
**Ungünstig:**
- In jeder TEILNAHME-Zeile stehen WorkshopTitel und LehrkraftName erneut.

**Folge:**
- Ändert sich ein Titel, müssen viele Zeilen geändert werden.

**Besser:**
```
WORKSHOP(WorkshopID, Titel, LehrkraftID)
LEHRKRAFT(LehrkraftID, Name)
TEILNAHME(SchuelerID, WorkshopID)
```

So wird jede Information an genau einer Stelle gepflegt (Single Source of Truth).

#### Redundanz und Anomalien
- **Änderungsanomalie:** Eine Änderung muss an vielen Stellen erfolgen.
- **Einfügeanomalie:** Neue Information kann nicht ohne andere Daten eingefügt werden.
- **Löschanomalie:** Beim Löschen gehen ungewollt weitere Informationen verloren.

#### Merksätze
- Eine Tatsache, ein Speicherort.
- Wiederholung von Stammdaten ist ein Warnsignal.
- Gute Modelle trennen Stammdaten und Vorgangsdaten.

#### Typische Fehler
- Namen statt IDs als Verbindung verwenden.
- Viele „bequeme" Duplikate in Zwischentabellen.
- Redundanz als „normal" akzeptieren.

#### Mini-Check
- Welche Information taucht mehrfach auf?
- Kann diese Information in einen eigenen Entitätstyp ausgelagert werden?
- Sind Beziehungen über Schlüssel statt über Klartext modelliert?

---

### Referentielle Integrität

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** Schulisches Lernlabor

#### Lernziele
- Du erklärst den Begriff referentielle Integrität korrekt.
- Du erkennst, wann Fremdschlüssel benötigt werden.
- Du beschreibst die Wirkung von Integritätsregeln.

#### Grundidee
Referentielle Integrität bedeutet: Ein Fremdschlüsselwert muss auf einen existierenden Primärschlüssel verweisen (oder NULL sein, falls erlaubt).

#### Beispiel aus dem Lernlabor
```
SCHUELER(SchuelerID PK, Name)
WORKSHOP(WorkshopID PK, Titel)
TEILNAHME(TeilnahmeID PK, SchuelerID FK, WorkshopID FK)
```

**Regel:**
- Eine Teilnahme darf nur existieren, wenn der zugehörige Schüler und der zugehörige Workshop existieren.

#### Warum ist das wichtig?
Ohne referentielle Integrität entstehen „verwaiste" Datensätze.

**Beispiel:**
- In TEILNAHME steht WorkshopID=77, aber Workshop 77 existiert nicht.
- Das führt zu fehlerhaften Auswertungen und unzuverlässigen Daten.

#### Integritätsaktionen (fachlich verstehen)
- **RESTRICT/NO ACTION:** Löschen/Ändern wird verhindert, wenn Verweise existieren.
- **CASCADE:** Änderungen/Löschungen werden auf abhängige Datensätze übertragen.
- **SET NULL:** FK wird auf NULL gesetzt (nur wenn erlaubt).

#### Merksätze
- Kein Fremdschlüssel ohne gültiges Ziel.
- Beziehungen brauchen technische Absicherung durch FK-Regeln.
- Datenqualität ist kein Zufall, sondern Regelwerk.

#### Typische Fehler
- Fremdschlüssel vergessen.
- Datentypen von PK und FK passen nicht zusammen.
- Löschregeln ohne fachliche Begründung wählen.

#### Klassenarbeitsfokus
Wenn ihr im EERM Beziehungen modelliert, denkt direkt mit:
- Wo liegt später der Fremdschlüssel?
- Welche Integritätsregel passt fachlich?

---

### MySQL Workbench Workflow

Diese Dateien wurden automatisch erzeugt mit:
```bash
bash scripts/prepare-workbench-mwb.sh
```

#### 1) Erzeugte Modelle

| System | Schema | Quelle | Ziel-.mwb |
|---|---|---|---|
| kursplattform | kursplattform | generated/klassenarbeiten/KA02_BG12_2025_2026_VERSION1_lsg.md | generated/klassenarbeiten/kursplattform_2025.mwb |

#### 2) Validierung

Die erzeugten Archive enthalten intern `document.mwb.xml`, `lock` und `@db/data.db`.

Beispielprüfung:
```bash
bash scripts/validate-mwb-native.sh
```

---

### Hilfsmittel für Teil B

#### Sachverhalt Modellierung (Kontext 1)
Eine Bildungseinrichtung betreibt eine Kursplattform. Teilnehmende buchen Kurse zu konkreten Terminen. Lehrkräfte betreuen Kurse, zum Teil im Team. Die Schulleitung benötigt später Auswertungen zu Buchungen pro Person, Terminen pro Kurs und Lehrkräften ohne aktive Zuordnung.

#### 1. Sachverhalt in Fachbegriffe zerlegen

Lies den Text einmal nur fachlich. Markiere:

- Dinge, die als Entitätstypen infrage kommen
- Verben, die Beziehungen andeuten
- Eigenschaften, die als Attribute brauchbar sind
- Formulierungen wie mehrfach, gemeinsam, zu Terminen, im Team oder ohne aktive Zuordnung

Für diesen Kontext führen die wichtigsten Kandidaten typischerweise zu:

- Teilnehmende
- Kurse
- Termine
- Lehrkräfte
- Buchungen

#### 2. Beziehungen mit Eine-Sätzen absichern

Nutze die Methode aus dem Informationsblatt zu Kardinalitäten:

- Eine Teilnehmende kann mehrere Buchungen haben.
- Eine Buchung gehört zu genau einer teilnehmenden Person.
- Ein Kurs hat mehrere Termine.
- Ein Termin gehört zu genau einem Kurs.
- Eine Lehrkraft kann mehrere Kurse betreuen.
- Ein Kurs kann im Team von mehreren Lehrkräften betreut werden.

Wenn du eine Beziehung in beide Richtungen mit mehreren Beteiligten formulieren kannst, prüfe zuerst eine n:m-Beziehung. Wenn eine Seite eindeutig genau eins ist, bleibt es bei 1:n.

#### 3. Entitätstypen und Schlüssel festlegen

Arbeite erst die Fachstruktur aus, dann die Technik:

- Jeder Entitätstyp bekommt einen Primärschlüssel.
- Fachliche Namen bleiben lesbar und kurz.
- Vermeide doppelte Speicherung derselben Information.

Für das Modell bedeutet das:

- Stammdaten wie Name oder Titel gehören in den passenden Entitätstyp.
- Buchungsinformationen gehören in die Buchung.
- Terminbezogene Angaben gehören in den Termin.

Wenn dir bei Attributen etwas fehlt, ergänze nur das Nötige für die Fachlogik und die Auswertung. Nicht jedes denkbare Detail muss modelliert werden.

#### 4. Das Modell in MySQL Workbench aufbauen

Baue das EERM in dieser Reihenfolge:

1. Entitätstypen anlegen
2. Primärschlüssel setzen
3. Beziehungen modellieren
4. Kardinalitäten eintragen
5. Nur dann Attribute ergänzen, wenn sie fachlich gebraucht werden

Für die Team-Betreuung gilt: Wenn ein Kurs von mehreren Lehrkräften betreut werden kann, dann muss die Beziehung zwischen Lehrkraft und Kurs fachlich als n:m gedacht werden. Eine Zwischentabelle oder Assoziation ist dann die saubere Lösung.

#### 5. Normalisierung bis 3NF prüfen

Gehe mit den drei Prüfungen aus dem Infoblatt vor:

- **1NF:** keine Listenwerte und keine zusammengesetzten Zellen
- **2NF:** bei zusammengesetzten Schlüsseln müssen Nichtschlüsselattribute vom ganzen Schlüssel abhängen
- **3NF:** keine transitiven Abhängigkeiten

**Praktische Leitfrage:**

- Steht eine Kurs- oder Lehrkraftinformation mehrfach in einer Buchung, ist das ein Warnsignal.
- Hängt ein Attribut nur indirekt über ein anderes Nichtschlüsselattribut ab, ist das kein 3NF-Zustand.

**Als Kontrollidee kannst du diese funktionalen Abhängigkeiten prüfen:**

- termin_id bestimmt kurs_id
- buchung_id bestimmt teilnehmer_id und termin_id

Wenn du solche Abhängigkeiten sauber trennen kannst, bist du auf dem richtigen Weg.

#### 6. Redundanzen und Anomalien benennen

Nimm die drei Standardfragen aus dem Infoblatt:

- Welche Information würde mehrfach auftauchen?
- Was müsste bei einer Änderung an mehreren Stellen angepasst werden?
- Was geht verloren, wenn ein Datensatz gelöscht wird?

**Beispielhafte Formulierung für die Lösung:**

- **Einfügeanomalie:** Eine neue Fachinformation lässt sich nicht unabhängig anlegen.
- **Änderungsanomalie:** Ein Kursname müsste an vielen Stellen gleichzeitig korrigiert werden.
- **Löschanomalie:** Beim Löschen eines Vorgangs verschwinden fachlich wichtige Restinformationen mit.

#### 7. Abschlusskontrolle vor der Abgabe

- Ist jeder Entitätstyp fachlich begründet?
- Sind alle Kardinalitäten mit Eine-Sätzen abgesichert?
- Gibt es keine doppelte Speicherung derselben Stammdaten?
- Sind die Fremdschlüsselbeziehungen fachlich nachvollziehbar?
- Ist die Modellierung unabhängig vom SQL-Teil gedacht?

---

## Teil C: SQL-Abfragen über mehrere Tabellen

### SQL-Abfragen über mehrere Tabellen

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** FoodTruckNetz (separat von Teil B)

#### Lernziele
- Du verbindest Tabellen fachlich korrekt mit JOIN.
- Du liest Join-Bedingungen sicher aus dem Schema.
- Du vermeidest ungewollte kartesische Produkte.

#### Kernidee
Daten liegen in normalisierten Tabellen verteilt. Für Auswertungen müssen Tabellen über Schlüssel verbunden werden.

#### Beispielkontext
```
FOODTRUCK(TruckID, Name)
STANDORT(StandortID, Stadt)
EINSATZ(EinsatzID, TruckID, StandortID, Datum)
```

#### Standardmuster
```sql
SELECT f.Name, s.Stadt, e.Datum
FROM EINSATZ e
JOIN FOODTRUCK f ON f.TruckID = e.TruckID
JOIN STANDORT s ON s.StandortID = e.StandortID;
```

#### Merksätze
- JOIN immer über PK/FK-Beziehungen.
- Ohne ON-Bedingung droht Datenexplosion.
- Erst FROM/JOIN sauber, dann WHERE ergänzen.

#### Typische Fehler
- Falsche Join-Spalten.
- Alias vergessen oder uneinheitlich.
- Filterbedingungen in ON und WHERE unklar mischen.

---

### Selektion in SQL

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** FoodTruckNetz

#### Lernziele
- Du filterst Datensätze mit WHERE korrekt.
- Du kombinierst Bedingungen mit AND, OR, NOT.
- Du nutzt Vergleichsoperatoren zielgerichtet.

#### Kernidee
Selektion bedeutet: Welche Zeilen sollen im Ergebnis enthalten sein?

#### Beispiele
```sql
SELECT Name, Kategorie
FROM FOODTRUCK
WHERE Kategorie = 'Vegan';
```

```sql
SELECT Name
FROM FOODTRUCK
WHERE Kategorie = 'Vegan' AND Rating >= 4.5;
```

#### Wichtige Operatoren
- `=, <>, >, >=, <, <=`
- `BETWEEN`
- `IN`
- `LIKE`
- `IS NULL`

#### Merksätze
- WHERE filtert Zeilen vor Gruppierung.
- Klammern erhöhen Lesbarkeit und Sicherheit.
- Textwerte immer in Anführungszeichen.

#### Typische Fehler
- AND/OR ohne Klammern falsch kombinieren.
- NULL mit = statt IS NULL prüfen.
- Tippfehler in Literalen.

---

### Gruppierung in SQL

**Zielgruppe:** Sekundarstufe II (Abschlussjahr)  
**Kontext:** FoodTruckNetz

#### Lernziele
- Du bildest Gruppen mit GROUP BY.
- Du wertest Gruppen mit Aggregatfunktionen aus.
- Du filterst Gruppen mit HAVING.

#### Grundmuster
```sql
SELECT Stadt, COUNT(*) AS Einsaetze
FROM STANDORT s
JOIN EINSATZ e ON e.StandortID = s.StandortID
GROUP BY Stadt;
```

#### HAVING statt WHERE
- **WHERE** filtert einzelne Zeilen vor der Gruppierung.
- **HAVING** filtert bereits gebildete Gruppen.

##### Beispiel:
```sql
SELECT Stadt, COUNT(*) AS Einsaetze
FROM STANDORT s
JOIN EINSATZ e ON e.StandortID = s.StandortID
GROUP BY Stadt
HAVING COUNT(*) >= 5;
```

#### Merksätze
- GROUP BY erzeugt Auswertungseinheiten.
- Aggregatfunktionen ohne GROUP BY liefern eine Gesamtsicht.
- HAVING prüft Gruppenbedingungen.

---

### Datenbankschema Stadtfahrradverleih

**Separater SQL-Kontext (3NF, Kontext 2) – anderer Kontext als Modellierung:**

Für Teil C wird absichtlich einen anderen Kontext verwendet als in Teil B (Kontext 1), damit die Modellierungslösung aus Teil B nicht indirekt vorgegeben wird. Die didaktische Trennung ist essenziell für die Unabhängigkeit der Aufgabenteile.

**Konkreter Sachverhalt:**
Ein kommunaler Stadtfahrradverleih verwaltet Kundinnen und Kunden, Stationen, Fahrräder, Ausleihen, Zahlungen und Wartungen (6 Entitätstypen). Die bereitgestellte Übungsdatenbank ist bereits in 3NF modelliert.

#### Struktur-Definition (6 Entitätstypen)

##### Tabelle: kunden
Speichert Personen, die sich beim Verleih registriert haben.

```sql
CREATE TABLE kunden (
  kunde_id INT PRIMARY KEY,
  vorname VARCHAR(50) NOT NULL,
  nachname VARCHAR(50) NOT NULL,
  wohnort VARCHAR(80) NOT NULL,
  registriert_am DATE NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);
```

**Beispieldaten:**
| kunde_id | vorname | nachname | wohnort | registriert_am | aktiv |
|---|---|---|---|---|---|
| 1 | Lea | Keller | Mitte | 2024-01-10 | 1 |
| 2 | Noah | Weber | Nord | 2024-02-02 | 1 |
| 3 | Mia | Schmidt | West | 2024-03-18 | 1 |
| 4 | Elias | Nguyen | Sued | 2024-04-04 | 1 |
| 5 | Lina | Bauer | Mitte | 2024-04-29 | 1 |
| 6 | Paul | Hoffmann | Nord | 2024-05-14 | 1 |

##### Tabelle: stationen
Speichert die Ausleih- und Rückgabestationen.

```sql
CREATE TABLE stationen (
  station_id INT PRIMARY KEY,
  stationsname VARCHAR(120) NOT NULL,
  stadtteil VARCHAR(80) NOT NULL,
  kapazitaet INT NOT NULL,
  aktiv TINYINT(1) NOT NULL DEFAULT 1
);
```

**Beispieldaten:**
| station_id | stationsname | stadtteil | kapazitaet | aktiv |
|---|---|---|---|---|
| 10 | Hauptbahnhof | Mitte | 30 | 1 |
| 11 | Campus Nord | Nord | 22 | 1 |
| 12 | Stadtpark | West | 18 | 1 |
| 13 | Rathaus | Sued | 16 | 1 |

##### Tabelle: fahrraeder
Speichert Fahrräder, ihre Typen und ihren aktuellen Zustand.

```sql
CREATE TABLE fahrraeder (
  fahrrad_id INT PRIMARY KEY,
  station_id INT NOT NULL,
  typname VARCHAR(80) NOT NULL,
  stundenpreis DECIMAL(6,2) NOT NULL,
  seriennummer VARCHAR(60) NOT NULL UNIQUE,
  zustand ENUM('verfuegbar','vermietet','wartung') NOT NULL DEFAULT 'verfuegbar',
  CONSTRAINT fk_fahrraeder_station FOREIGN KEY (station_id) REFERENCES stationen(station_id)
);
```

**Beispieldaten:**
| fahrrad_id | station_id | typname | stundenpreis | seriennummer | zustand |
|---|---|---|---|---|---|
| 100 | 10 | City | 3.50 | SN-C-100 | verfuegbar |
| 101 | 10 | E-Bike | 5.80 | SN-E-101 | vermietet |
| 102 | 11 | Trekking | 4.20 | SN-T-102 | verfuegbar |
| 103 | 11 | City | 3.50 | SN-C-103 | wartung |
| 104 | 12 | E-Bike | 5.80 | SN-E-104 | verfuegbar |
| 105 | 12 | City | 3.50 | SN-C-105 | verfuegbar |
| 106 | 13 | Trekking | 4.20 | SN-T-106 | verfuegbar |
| 107 | 13 | City | 3.50 | SN-C-107 | vermietet |

##### Tabelle: ausleihen
Speichert die Ausleihen (Vorgänge): wer, wann, welches Fahrrad, von wo bis wo.

```sql
CREATE TABLE ausleihen (
  ausleihe_id INT PRIMARY KEY,
  kunde_id INT NOT NULL,
  fahrrad_id INT NOT NULL,
  start_station_id INT NOT NULL,
  ziel_station_id INT NOT NULL,
  startzeit DATETIME NOT NULL,
  endzeit DATETIME,
  status ENUM('laufend','abgeschlossen','storniert') NOT NULL DEFAULT 'laufend',
  CONSTRAINT fk_ausleihe_kunde FOREIGN KEY (kunde_id) REFERENCES kunden(kunde_id),
  CONSTRAINT fk_ausleihe_fahrrad FOREIGN KEY (fahrrad_id) REFERENCES fahrraeder(fahrrad_id),
  CONSTRAINT fk_ausleihe_start_station FOREIGN KEY (start_station_id) REFERENCES stationen(station_id),
  CONSTRAINT fk_ausleihe_ziel_station FOREIGN KEY (ziel_station_id) REFERENCES stationen(station_id)
);
```

**Beispieldaten:**
| ausleihe_id | kunde_id | fahrrad_id | start_station_id | ziel_station_id | startzeit | endzeit | status |
|---|---|---|---|---|---|---|---|
| 2000 | 1 | 100 | 10 | 12 | 2025-03-10 08:10:00 | 2025-03-10 09:05:00 | abgeschlossen |
| 2001 | 2 | 101 | 10 | 11 | 2025-03-10 09:20:00 | 2025-03-10 10:00:00 | abgeschlossen |
| 2002 | 3 | 102 | 11 | 10 | 2025-03-10 10:10:00 | NULL | laufend |
| 2003 | 1 | 104 | 12 | 13 | 2025-03-11 08:00:00 | 2025-03-11 09:10:00 | abgeschlossen |
| 2004 | 4 | 105 | 12 | 10 | 2025-03-11 11:20:00 | 2025-03-11 12:15:00 | abgeschlossen |
| 2005 | 5 | 106 | 13 | 12 | 2025-03-12 07:40:00 | 2025-03-12 08:10:00 | abgeschlossen |
| 2006 | 2 | 107 | 13 | 10 | 2025-03-12 09:00:00 | NULL | laufend |
| 2007 | 6 | 100 | 10 | 11 | 2025-03-12 12:30:00 | 2025-03-12 13:05:00 | abgeschlossen |

##### Tabelle: wartungen
Speichert die Wartungshistorie der Fahrräder.

```sql
CREATE TABLE wartungen (
  wartung_id INT PRIMARY KEY,
  fahrrad_id INT NOT NULL,
  wartungsdatum DATE NOT NULL,
  wartungsart ENUM('Inspektion','Reparatur','Sicherheitscheck') NOT NULL,
  bemerkung VARCHAR(255) NOT NULL,
  CONSTRAINT fk_wartung_fahrrad FOREIGN KEY (fahrrad_id) REFERENCES fahrraeder(fahrrad_id)
);
```

**Beispieldaten:**
| wartung_id | fahrrad_id | wartungsdatum | wartungsart | bemerkung |
|---|---|---|---|---|
| 3000 | 103 | 2025-03-05 | Inspektion | Bremsen und Licht geprueft |
| 3001 | 104 | 2025-03-06 | Sicherheitscheck | Rahmen und Reifen kontrolliert |
| 3002 | 101 | 2025-03-07 | Reparatur | Akku-Stecker ersetzt |

##### Tabelle: zahlungen
Speichert die Zahlungsinformationen zu den Ausleihen.

```sql
CREATE TABLE zahlungen (
  zahlung_id INT PRIMARY KEY,
  ausleihe_id INT NOT NULL,
  betrag DECIMAL(7,2) NOT NULL,
  zahlart ENUM('Karte','Lastschrift','App') NOT NULL,
  bezahlt_am DATETIME NOT NULL,
  zahlstatus ENUM('offen','bezahlt','storniert') NOT NULL DEFAULT 'bezahlt',
  CONSTRAINT fk_zahlung_ausleihe FOREIGN KEY (ausleihe_id) REFERENCES ausleihen(ausleihe_id)
);
```

**Beispieldaten:**
| zahlung_id | ausleihe_id | betrag | zahlart | bezahlt_am | zahlstatus |
|---|---|---|---|---|---|
| 4000 | 2000 | 6.90 | Karte | 2025-03-10 09:07:00 | bezahlt |
| 4001 | 2001 | 5.80 | App | 2025-03-10 10:02:00 | bezahlt |
| 4002 | 2003 | 8.70 | Lastschrift | 2025-03-11 09:12:00 | bezahlt |
| 4003 | 2004 | 6.30 | Karte | 2025-03-11 12:20:00 | bezahlt |
| 4004 | 2005 | 4.20 | App | 2025-03-12 08:12:00 | bezahlt |
| 4005 | 2007 | 4.50 | Karte | 2025-03-12 13:10:00 | bezahlt |

#### Wichtige Übersicht für Teil C

| Tabelle | Wozu sie dient | Wichtige Schlüsselspalten |
|---|---|---|
| kunden | Personen | kunde_id |
| stationen | Start- und Zielorte | station_id |
| fahrraeder | Fahrräder und Typen | fahrrad_id, station_id |
| ausleihen | Vorgänge | ausleihe_id, kunde_id, fahrrad_id, start_station_id, ziel_station_id |
| wartungen | Wartungshistorie | wartung_id, fahrrad_id |
| zahlungen | Zahlungsdaten | zahlung_id, ausleihe_id |

#### Wichtige Ergänzungen aus dem Strukturdump:

- Der Zielkontext ist eine eigene 3NF-Datenbank mit dem Namen `stadtfahrradverleihdb_2025`.
- Start- und Zielstation sind zwei Rollen derselben Tabelle `stationen`, deshalb brauchst du zwei Aliase.
- Für Auswertungen zählen nur abgeschlossene Ausleihen.

---

### Hilfsmittel für Teil C

#### Sachverhalt für Teil C
Ein kommunaler Stadtfahrradverleih verwaltet die oben beschriebene Datenbank. Für die Auswertungen brauchst du saubere Join-Ketten und korrekte Filter-, Gruppierungs- und Aggregationsschritte.

#### 1. Zuerst das Schema lesen

Die technische Grundlage liegt in den Tabellen (siehe oben). Die wichtigsten Punkte:

- Die **6 Entitätstypen** sind: kunden, stationen, fahrraeder, ausleihen, wartungen, zahlungen
- **Fremdschlüssel** zeigen die Beziehungen zwischen den Tabellen
- **Rollen:** Start- und Zielstation sind zwei Rollen derselben Tabelle
- **Status:** Nur Ausleihen mit status = 'abgeschlossen' gehören zu den meisten Auswertungen

#### 2. Aufgabe 4.1 Schritt für Schritt

**Ziel:** Kundennamen, Fahrradnummer, Fahrradtyp, Start- und Zielstation sowie Zahlbetrag ausgeben.

**Arbeitsreihenfolge:**

1. Nimm **ausleihen** als Basistabelle.
2. Verbinde **kunden** über `kunde_id`.
3. Verbinde **fahrraeder** über `fahrrad_id`.
4. Verbinde **stationen** zweimal, einmal für `start_station_id` und einmal für `ziel_station_id`.
5. Verbinde **zahlungen** über `ausleihe_id`.
6. Filtere auf `status = 'abgeschlossen'`.
7. Sortiere nach Kundennachname und startzeit.

**Kontrollfrage:**

- Wenn ein Ausgabefeld aus einer anderen Tabelle kommt, fehlt meist genau dieser Join.

#### 3. Aufgabe 4.2 Schritt für Schritt

**Ziel:** je Person die Anzahl abgeschlossener Ausleihen, aber nur ab 2.

**Arbeitsreihenfolge:**

1. Starte wieder bei **kunden** und **ausleihen**.
2. Begrenze die Zeilen auf abgeschlossene Ausleihen.
3. Bilde die Gruppen pro Person.
4. Zähle die Ausleihen je Gruppe.
5. Filtere die Gruppen mit mindestens 2 über **HAVING**.

**Merksatz:**

- **WHERE** filtert Zeilen.
- **HAVING** filtert Gruppen.

#### 4. Aufgabe 4.3 Schritt für Schritt

**Ziel:** pro Station den letzten Ausleihstart und die Anzahl unterschiedlicher Kundinnen und Kunden.

**Arbeitsreihenfolge:**

1. Verbinde **stationen** mit **ausleihen** über `start_station_id`.
2. Gib pro Station genau eine Ergebniszeile aus.
3. Ermittle den letzten Start mit `MAX(startzeit)`.
4. Zähle unterschiedliche Personen mit `COUNT(DISTINCT kunde_id)`.
5. Gruppiere nach `station_id` und stationsname.

**Kontrollfrage:**

- Wenn du mehr als eine Zeile pro Station erhältst, fehlt die Gruppierung oder sie ist zu grob.

#### 5. Aufgabe 4.4 Schritt für Schritt

**Ziel:** Fahrräder ohne dokumentierte Wartung.

**Arbeitsreihenfolge:**

1. Nimm **fahrraeder** als Basistabelle.
2. Verbinde **wartungen** per **LEFT JOIN** über `fahrrad_id`.
3. Suche die Fahrräder, bei denen keine Wartung gefunden wurde.
4. Prüfe dafür das NULL-Feld aus der Wartungstabelle.

**Merksatz:**

- Ein **LEFT JOIN** behält die linke Tabelle vollständig und zeigt rechts NULL, wenn kein Treffer existiert.

#### 6. Prüfstrategie vor dem Abgeben

- Stimmen alle Join-Spalten mit den Fremdschlüsseln aus dem Strukturdump überein?
- Ist die Rolle der stationen-Tabelle zweimal sauber getrennt?
- Ist der Statusfilter nur bei abgeschlossenen Ausleihen gesetzt?
- Werden Gruppen erst nach dem GROUP BY mit HAVING geprüft?
- Ist die Abfrage ohne unnötige Wiederholungen gebaut?

---

## Teil D: Grundlagen Programmierung

### Aufgabe: Struktogramm – Fahrradverleih Kostenberechnung

Ein Kunde möchte wissen, wie viel eine Fahrradausleihe kostet.

**Erstellen Sie ein Struktogramm** (gemäß Operatorenliste für Struktogramme) für folgende Verarbeitung:

- **Eingabe:** Anzahl der Ausleih-Tage und Tagespreis in Euro
- **Verarbeitung:** Berechnung der Gesamtkosten
- **Ausgabe:** Gesamtkosten in Euro

**Hinweis:** Verwenden Sie ausschließlich Sequenz-Blöcke (EVA-Prinzip).
Kontrollstrukturen (Schleifen, Verzweigungen) werden **nicht** bewertet und sind nicht erforderlich.

#### Bewertungskriterien

| Bewertungskriterium | Punkte |
|---|---:|
| Struktogramm-Rahmen (ANFANG/ENDE) und 3 Sequenzblöcke vollständig | 1,0 |
| Berechnungsformel korrekt (Zuweisung mit :=) | 1,5 |
| Variablennamen und Lesbarkeit | 0,5 |
| **Gesamt** | **3,0** |

#### Musterlösung (Text-Notation gemäß Operatorenliste):
```
ANFANG
  EINGABE: tage
  EINGABE: tagespreis
  gesamtkosten := tage * tagespreis
  AUSGABE: gesamtkosten
ENDE
```

---

## Aufgabenstellung

### Aufgabe 3.1: EERM modellieren – 8 Punkte

**Sachverhalt Modellierung (Kontext 1):**

Eine Bildungseinrichtung betreibt eine Kursplattform. Teilnehmende buchen Kurse zu konkreten Terminen. Lehrkräfte betreuen Kurse, zum Teil im Team. Die Schulleitung benötigt später Auswertungen zu Buchungen pro Person, Terminen pro Kurs und Lehrkräften ohne aktive Zuordnung.

**Auftrag:** Leiten Sie aus dem Sachverhalt ein geeignetes EERM in MySQL Workbench ab. Begründen Sie Ihre Modellierungsentscheidungen kurz.

### Aufgabe 3.2: Normalisierung bis 3NF – 4 Punkte
- Benennen Sie 2 funktionale Abhängigkeiten.
- Begründen Sie, warum das Modell in 3NF liegt.

### Aufgabe 3.3: Anomalien – 2 Punkte
Nennen Sie je ein Beispiel:
- Einfügeanomalie
- Änderungsanomalie
- Löschanomalie

### Aufgabe 4.1 (4 Punkte)
Geben Sie für jede abgeschlossene Ausleihe den Kundennamen, die Fahrradnummer, den Fahrradtyp, Start- und Zielstation sowie den Zahlbetrag aus.
Sortierung: Kundennachname, Startzeit.

### Aufgabe 4.2 (4 Punkte)
Ermitteln Sie je Kundin/Kunde die Anzahl abgeschlossener Ausleihen. Zeigen Sie nur Personen mit mindestens 2 abgeschlossenen Ausleihen.

### Aufgabe 4.3 (3 Punkte)
Geben Sie pro Station den letzten Ausleihstart und die Anzahl unterschiedlicher Kundinnen/Kunden aus, die dort gestartet sind.

### Aufgabe 4.4 (3 Punkte)
Finden Sie Fahrräder ohne dokumentierte Wartung (LEFT JOIN).

---

## Musterlösungen und Erwartungshorizont

### Musterlösung Teil A

| Nr. | Aussage | r/f |
|-----|---------|-----|
| 1 | Ein Fremdschlüssel darf mehrfach vorkommen. | r |
| 2 | Eine N:M-Beziehung wird in relationalen Modellen direkt ohne Zwischentabelle gespeichert. | f |
| 3 | Ein LEFT JOIN kann Datensätze ohne Partner auf der rechten Seite sichtbar machen. | r |
| 4 | Die 3NF reduziert Redundanz und Anomalien. | r |
| 5 | Ein Primärschlüssel darf NULL sein. | f |
| 6 | HAVING filtert Gruppen nach GROUP BY. | r |

---

### Musterlösung Teil B: Aufgabe 3.1

**Korrekte Entitätstypen und Begründung:**

- **TEILNEHMENDE** (Stammtabelle für Schüler/Studenten)
- **KURS** (Grundkurs mit Name und Beschreibung)
- **TERMIN** (konkrete Termine eines Kurses)
- **LEHRKRAFT** (Unterrichtende)
- **BUCHUNG** (Verbindung: wer bucht welchen Termin)
- **KURS_LEHRKRAFT** oder **BETREUUNG** (falls n:m zwischen Kurs und Lehrkraft modelliert wird)

**Kardinalitäten und Eine-Sätze:**

- Eine Teilnehmende kann 0 bis n Buchungen haben.
- Eine Buchung gehört zu genau einer Teilnehmenden.
- Ein Kurs hat 1 bis n Termine.
- Ein Termin gehört zu genau einem Kurs.
- Eine Lehrkraft betreut 0 bis n Kurse.
- Ein Kurs kann von 1 bis n Lehrkräften betreut werden.

**Attributzuweisung:**

- **TEILNEHMENDE:** teilnehmer_id (PK), vorname, nachname, email
- **KURS:** kurs_id (PK), kurstitel, beschreibung
- **TERMIN:** termin_id (PK), kurs_id (FK), startdatum, enddatum
- **LEHRKRAFT:** lehrkraft_id (PK), vorname, nachname, fachbereich
- **BUCHUNG:** buchung_id (PK), teilnehmer_id (FK), termin_id (FK)
- **KURS_LEHRKRAFT:** kurs_lehrkraft_id (PK), kurs_id (FK), lehrkraft_id (FK)

**Bewertung (8 Punkte):**
- Entitätstypen korrekt identifiziert: 2 Pkt
- Beziehungen korrekt: 3 Pkt
- Kardinalitäten korrekt: 1 Pkt
- Attributzuweisung sinnvoll: 2 Pkt

---

### Musterlösung Teil B: Aufgabe 3.2

**Funktionale Abhängigkeiten:**

1. **termin_id → kurs_id** (jeder Termin gehört zu genau einem Kurs)
2. **buchung_id → teilnehmer_id, termin_id** (jede Buchung identifiziert eindeutig eine Person und einen Termin)
3. **kurs_id → lehrkraft_id** (wenn 1:n) oder keine direkte Abhängigkeit (wenn n:m mit Zwischentabelle)

**3NF-Begründung:**

Das Modell liegt in 3NF vor, weil:
- Alle Attributwerte sind atomar (1NF erfüllt).
- Alle Nichtschlüsselattribute hängen vollständig von ihrem Primärschlüssel ab (2NF erfüllt).
- Es gibt keine transitiven Abhängigkeiten zwischen Nichtschlüsselattributen und anderen Nichtschlüsselattributen (3NF erfüllt).

Beispiel: In der BUCHUNG hängt der Teilnehmernachname nicht von der termin_id ab, sondern ist in die TEILNEHMENDE-Tabelle ausgelagert. Somit entstehen keine Redundanzen.

**Bewertung:** je 1 Pkt pro funktionale Abhängigkeit (2 Pkt) + Begründung 3NF (2 Pkt)

---

### Musterlösung Teil B: Aufgabe 3.3

**Beispiele für Anomalien:**

- **Einfügeanomalie:** Wenn Kursinformationen nur über die Buchung gespeichert werden, lässt sich ein neuer Kurs nicht anlegen, bevor es Buchungen gibt.
- **Änderungsanomalie:** Wenn der Kursname in einer denormalisierten Tabelle mehrfach vorkommt, müssen alle Einträge gleichzeitig angepasst werden.
- **Löschanomalie:** Wenn der letzte Termin eines Kurses gelöscht wird, gehen alle Kursinformationen verloren (falls nicht separat gespeichert).

**Bewertung:** je 0,5 Pkt pro Beispiel (max. 2 Pkt für je ein sinnvolles Beispiel)

---

### Musterlösung Teil C: Aufgabe 4.1

**SQL-Abfrage:**
```sql
SELECT
  k.nachname, k.vorname,
  f.fahrrad_id,
  f.typname,
  s1.stationsname AS startstation,
  s2.stationsname AS zielstation,
  z.betrag
FROM ausleihen a
JOIN kunden k ON a.kunde_id = k.kunde_id
JOIN fahrraeder f ON a.fahrrad_id = f.fahrrad_id
JOIN stationen s1 ON a.start_station_id = s1.station_id
JOIN stationen s2 ON a.ziel_station_id = s2.station_id
JOIN zahlungen z ON a.ausleihe_id = z.ausleihe_id
WHERE a.status = 'abgeschlossen'
ORDER BY k.nachname, a.startzeit;
```

**Erwartetes Ergebnis (Auszug):**
| nachname | vorname | fahrrad_id | typname | startstation | zielstation | betrag |
|---|---|---|---|---|---|---|
| Bauer | Lina | 106 | Trekking | Rathaus | Stadtpark | 4.20 |
| Hoffmann | Paul | 100 | City | Hauptbahnhof | Campus Nord | 4.50 |
| Keller | Lea | 100 | City | Hauptbahnhof | Stadtpark | 6.90 |
| Nguyen | Elias | 105 | City | Stadtpark | Hauptbahnhof | 6.30 |
| Weber | Noah | 101 | E-Bike | Hauptbahnhof | Campus Nord | 5.80 |

**Bewertung:** 
- JOIN-Kette vollständig: 2 Pkt
- WHERE-Bedingung korrekt: 1 Pkt
- ORDER BY korrekt: 1 Pkt

---

### Musterlösung Teil C: Aufgabe 4.2

**SQL-Abfrage:**
```sql
SELECT k.nachname, k.vorname, COUNT(a.ausleihe_id) AS anzahl_ausleihen
FROM kunden k
JOIN ausleihen a ON k.kunde_id = a.kunde_id
WHERE a.status = 'abgeschlossen'
GROUP BY k.kunde_id, k.nachname, k.vorname
HAVING COUNT(a.ausleihe_id) >= 2
ORDER BY anzahl_ausleihen DESC;
```

**Erwartetes Ergebnis:**
| nachname | vorname | anzahl_ausleihen |
|---|---|---|
| Keller | Lea | 2 |
| Weber | Noah | 2 |

**Bewertung:** 
- GROUP BY korrekt: 1 Pkt
- HAVING korrekt: 2 Pkt
- Spaltenselektion korrekt: 1 Pkt

---

### Musterlösung Teil C: Aufgabe 4.3

**SQL-Abfrage:**
```sql
SELECT
  s.stationsname,
  MAX(a.startzeit) AS letzter_start,
  COUNT(DISTINCT a.kunde_id) AS unterschiedliche_kunden
FROM stationen s
JOIN ausleihen a ON s.station_id = a.start_station_id
GROUP BY s.station_id, s.stationsname;
```

**Erwartetes Ergebnis:**
| stationsname | letzter_start | unterschiedliche_kunden |
|---|---|---|
| Hauptbahnhof | 2025-03-12 12:30:00 | 4 |
| Campus Nord | 2025-03-10 10:10:00 | 1 |
| Stadtpark | 2025-03-11 11:20:00 | 1 |
| Rathaus | 2025-03-12 07:40:00 | 1 |

**Bewertung:** 
- MAX-Aggregation korrekt: 1 Pkt
- COUNT DISTINCT korrekt: 1 Pkt
- GROUP BY korrekt: 1 Pkt

---

### Musterlösung Teil C: Aufgabe 4.4

**SQL-Abfrage:**
```sql
SELECT f.fahrrad_id, f.typname, f.seriennummer
FROM fahrraeder f
LEFT JOIN wartungen w ON f.fahrrad_id = w.fahrrad_id
WHERE w.wartung_id IS NULL;
```

**Erwartetes Ergebnis:**
| fahrrad_id | typname | seriennummer |
|---|---|---|
| 100 | City | SN-C-100 |
| 102 | Trekking | SN-T-102 |
| 105 | City | SN-C-105 |
| 106 | Trekking | SN-T-106 |
| 107 | City | SN-C-107 |

**Bewertung:** 
- LEFT JOIN korrekt: 1,5 Pkt
- IS NULL Bedingung korrekt: 1,5 Pkt

---

### Musterlösung Teil D

**Struktogramm (Text-Notation):**
```
ANFANG
  EINGABE: tage
  EINGABE: tagespreis
  gesamtkosten := tage * tagespreis
  AUSGABE: gesamtkosten
ENDE
```

**Bewertungshinweise:**
- **1,0 Pkt:** ANFANG/ENDE vorhanden, 4 Sequenzblöcke sauber abgegrenzt (je 0,25 Pkt)
- **1,5 Pkt:** Zuweisung `gesamtkosten := tage * tagespreis` korrekt (Operator := und Formel je 0,75 Pkt)
- **0,5 Pkt:** Variablennamen aussagekräftig und einheitlich

---

## Abgabe

- **EERM-Modellierung Teil B** (von Schülern erstellt): als `.mwb`-Datei abgeben
- **SQL-Lösungen Teil C:** als Datei oder Text
- **Struktogramm Teil D:** als Bild oder Text-Notation

---

## Kurzlösungsschlüssel (Lehrkraft)

**Aufgabe 1:** r, f, r, r, f, r

**Lösungshinweise Teil C:**
- **4.1:** benötigt JOIN über mindestens: ausleihen, kunden, fahrraeder, stationen (2x), zahlungen
- **4.2:** benötigt GROUP BY/HAVING auf kunden + ausleihen
- **4.3:** benötigt Aggregation pro station + MAX(startzeit)
- **4.4:** benötigt LEFT JOIN fahrraeder → wartungen und IS NULL

---

## Anhang: Wichtige Merksätze und Tipps

### Für die Modellierung (Teil B)
- **Fachlogik zuerst:** Denke immer zuerst an die realen Verhältnisse, nicht an technische Tricks.
- **Eine-Sätze:** Keine Kardinalität ohne begründenden Eine-Satz.
- **Normalisierung:** Wenn die gleiche Information mehrfach auftaucht, ist es ein Warnsignal.

### Für SQL-Abfragen (Teil C)
- **Join-Strategie:** Basistabelle wählen, dann systematisch alle nötigen Tabellen anhängen.
- **Filter-Logik:** WHERE für Zeilen, HAVING für Gruppen.
- **Alias nutzen:** Besonders bei mehrfachen Joins auf dieselbe Tabelle (wie bei Start/Zielstation).

### Für die Abgabe
- Alle Dateien müssen leserlich und vollständig sein.
- Begründungen kurz, aber präzise.
- SQL-Code sollte formatiert und kommentiert sein.

---

**Ende des Kompendiums**

---

*Dieses Dokument fasst alle Anleitungen, Informationsblätter und Aufgabenstellungen für die Klassenarbeit Version 1 zusammen. Es soll als umfassendes Nachschlagewerk während der Vorbereitung und als Lernressource dienen.*
