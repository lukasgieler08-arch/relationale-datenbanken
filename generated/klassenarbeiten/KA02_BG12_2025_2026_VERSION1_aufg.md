---
titel: "Klassenarbeit BG12 2025/2026: EERM und SQL (60 Min)"
klasse: "BG12"
schuljahr: "2025-2026"
fach: "Informatik"
bearbeitungszeit: "60 Minuten"
erreichbare_punkte: 34
verteilung:
  modellierung_normalisierung_anomalien: 14
  abfragen_mehrtabellen: 14
  theorie_mc: 3
  struktogramm: 3
artefakte:
  modellierung_eerm_lehrkraft: "kursplattform_2025.mwb"
  sql_db_dump: "stadtfahrradverleih_struktur_2025.sql"
  sql_db_daten: "stadtfahrradverleih_daten_2025.sql"
  sql_db_eerm: "stadtfahrradverleih_2025.mwb"
  sql_db_eerm_grafik: "stadtfahrradverleih_2025.png"
fassung: aufgaben
---

# Klassenarbeit (60 Minuten)

**Klasse/Kurs:** BG12 | **Schuljahr:** 2025/2026 | **Bearbeitungszeit:** 60 Minuten | **Erreichbare Punkte:** 34

---

## Struktur

| Teil | Inhalte | Punkte | Zeit |
|---|---|---:|---:|
| A | Theorie (MC) | 3 | 5 Min |
| B | EERM, Normalisierung, Anomalien | 14 | 25 Min |
| C | SQL-Abfragen ueber mehrere Tabellen | 14 | 25 Min |
| D | Grundlagen Programmierung (Struktogramm) | 3 | 5 Min |
| **Gesamt** |  | **34** | **60 Min** |

---

## Teil A (3 Punkte)

### Aufgabe 1: Theorie (Multiple Choice) – 3 Punkte
Markieren Sie richtig/falsch. (0,5 Punkte je Aussage)

| Nr. | Aussage | r/f |
|-----|---------|-----|
| 1 | Ein Fremdschluessel darf mehrfach vorkommen. | |
| 2 | Eine N:M-Beziehung wird in relationalen Modellen direkt ohne Zwischentabelle gespeichert. | |
| 3 | Ein LEFT JOIN kann Datensaetze ohne Partner auf der rechten Seite sichtbar machen. | |
| 4 | Die 3NF reduziert Redundanz und Anomalien. | |
| 5 | Ein Primarschluessel darf NULL sein. | |
| 6 | HAVING filtert Gruppen nach GROUP BY. | |

---

## Teil B (14 Punkte): EERM in MySQL Workbench

**Wichtig:** Teil B ist eine reine Modellierungsaufgabe. Es wird bewusst kein fertiges SQL-Schema vorgegeben. Die Struktur muss selbst aus dem Sachverhalt entwickelt werden.

### Aufgabe 3.1: EERM modellieren – 8 Punkte

**Sachverhalt Modellierung (Kontext 1):**

Eine Bildungseinrichtung betreibt eine Kursplattform. Teilnehmende buchen Kurse zu konkreten Terminen. Lehrkraefte betreuen Kurse, zum Teil im Team. Die Schulleitung benoetigt spaeter Auswertungen zu Buchungen pro Person, Terminen pro Kurs und Lehrkraeften ohne aktive Zuordnung.

**Auftrag:** Leiten Sie aus dem Sachverhalt ein geeignetes EERM in MySQL Workbench ab. Begruenden Sie Ihre Modellierungsentscheidungen kurz.

### Aufgabe 3.2: Normalisierung bis 3NF – 4 Punkte
- Benennen Sie 2 funktionale Abhaengigkeiten.
- Begruenden Sie, warum das Modell in 3NF liegt.

### Aufgabe 3.3: Anomalien – 2 Punkte
Nennen Sie je ein Beispiel:
- Einfuegeanomalie
- Aenderungsanomalie
- Loschanomalie

---

## Teil C (14 Punkte): SQL-Abfragen ueber mehrere Tabellen

**Separater SQL-Kontext (3NF, Kontext 2) – anderen Kontext als Modellierung:**
Fuer Teil C wird absichtlich einen anderen Kontext verwendet als in Teil B (Kontext 1), damit die Modellierungsloesung aus Teil B nicht indirekt vorgegeben wird.
Die didaktische Trennung ist essentiell fuer die Unabhaengigkeit der Aufgabenteile.

**Konkreter Sachverhalt:**
Ein kommunaler Stadtfahrradverleih verwaltet Kundinnen und Kunden, Stationen, Fahrraeder, Ausleihen, Zahlungen und Wartungen (6 Entitaetstypen). Die bereitgestellte Uebungsdatenbank ist bereits in 3NF modelliert.

**Arbeitsgrundlage:**
- SQL-Struktur: `stadtfahrradverleih_struktur_2025.sql`
- SQL-Daten: `stadtfahrradverleih_daten_2025.sql`
- EERM-Referenzgrafik: `stadtfahrradverleih_2025.png`

![EERM Teil C - separater SQL-Kontext](./stadtfahrradverleih_2025.png)

### Aufgabe 4.1 (4 Punkte)
Geben Sie fuer jede abgeschlossene Ausleihe den Kundennamen, die Fahrradnummer, den Fahrradtyp, Start- und Zielstation sowie den Zahlbetrag aus.
Sortierung: Kundennachname, Startzeit.

### Aufgabe 4.2 (4 Punkte)
Ermitteln Sie je Kundin/Kunde die Anzahl abgeschlossener Ausleihen. Zeigen Sie nur Personen mit mindestens 2 abgeschlossenen Ausleihen.

### Aufgabe 4.3 (3 Punkte)
Geben Sie pro Station den letzten Ausleihstart und die Anzahl unterschiedlicher Kundinnen/Kunden aus, die dort gestartet sind.

### Aufgabe 4.4 (3 Punkte)
Finden Sie Fahrraeder ohne dokumentierte Wartung (LEFT JOIN).

---

## Teil D (3 Punkte): Grundlagen Programmierung

### Aufgabe 2: Struktogramm (am Ende bearbeiten)
Erstellen Sie ein Struktogramm fuer folgende Logik (BPE 5.1):
- Eingabe: Punktezahl einer Teilleistung
- Gueltig sind Werte von 0 bis 15
- Bei ungueltiger Eingabe erneut abfragen
- Bei gueltiger Eingabe: "Eingabe gueltig"

**Wichtig:** Keine Arrays und keine Listen verwenden (Arrays/Listen gehoeren zu BPE 7).
Fokus auf Eingabe, Bedingung, Schleife und Ausgabe.

Bewertung: Logik 1,5 Pkt | Strukturbloecke 1,0 Pkt | Lesbarkeit 0,5 Pkt

---

## Abgabe

- EERM-Modellierung Teil B (von Schuelern erstellt): als `.mwb`-Datei abgeben
- SQL-Loesungen Teil C: als Datei oder Text
