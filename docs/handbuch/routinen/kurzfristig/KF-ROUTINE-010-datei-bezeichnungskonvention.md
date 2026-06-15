# KF-ROUTINE-010: Benennungskonvention für Klassenarbeits-Artefakte

## Metadata
- ID: KF-ROUTINE-010
- Kategorie: kurzfristig
- Status: aktiv
- Version: 1.1
- Gueltig ab: 11.05.2026
- Zielgruppe: Lehrkraefte und Autoren von Klassenarbeiten/Pruefungen
- Abhaengigkeiten:
  - KF-ROUTINE-008-separater-sql-3nf-kontext.md
  - KF-ROUTINE-009-eerm-png-generator.md

## Ziel
Einheitliche, aussagekraeftige Benennung aller Dateiartefakte im Klassenaarbeitsverzeichnis (`generated/klassenarbeiten`), damit Lehrkraefte und Schueler sofort erkennen, um welche Dateiart es sich handelt und fuer welchen Sachverhalt/Schuljahr.

## Namenskonvention

### A) Modell-Container (.mwb)
**Format:** `{Systemname}_{Jahr}.mwb`
**Beispiel:** `kursplattform_2025.mwb`

- Systemname: ggf. mit Umlauten (z.B. `kursplattform`, `stadtfahrradverleih`)
- Jahr: Schuljahrescode (z.B. 2025, 2026)
- Kurz und aussagekraeftig, keine Jahrspannen oder Versionsindizes im Dateinamen

### B) SQL-Struktur-Dumps (.sql)
**Format:** `{Systemname}_struktur_{Jahr}.sql`
**Beispiel:** `stadtfahrradverleih_struktur_2025.sql`

- Enthaelt: CREATE DATABASE, DROP/CREATE TABLE und Constraints (Fremdschluessel, Indizes)
- KEINE INSERT/UPDATE/DELETE Statements
- Eine Datei pro Sachverhalt/Modell
- Klar identifizierbar als Struktur-Definition

### C) SQL-Daten-Dumps (.sql)
**Format:** `{Systemname}_daten_{Jahr}.sql`
**Beispiel:** `stadtfahrradverleih_daten_2025.sql`

- Enthaelt: USE-Statement und INSERT Statements
- KEINE CREATE TABLE oder DROP Statements
- Musterdatensaetze fuer Abfragen und Tests
- Separate Datei von der Struktur

### D) Klassenarbeit-Aufgaben-Markdown (.md)
**Format:** `KA{KANummer}_{Zielgruppe}_{Schuljahr}_{Version}_aufg.md`
**Beispiel:** `KA02_BG12_2025_2026_VERSION1_aufg.md`

- KANummer: z.B. KA02 (2. Klassenarbeit des Schuljahres)
- Zielgruppe: z.B. BG12 (Berufsgymnasium Klasse 12)
- Schuljahr: z.B. 2025_2026 (von 2025 bis 2026)
- Version: z.B. VERSION1, VERSION2 etc.
- Suffix `_aufg`: kennzeichnet die Schuelerfassung (Aufgabenstellung + Artefakt-Hinweise, OHNE Loesung)
- Enthaelt: Aufgabenstellung, Arbeitsblatt-Hinweise, Artefakt-Verweise (mwb, PNG, SQL-Dumps)

### E) Klassenarbeit-Loesung-Markdown (.md)
**Format:** `KA{KANummer}_{Zielgruppe}_{Schuljahr}_{Version}_lsg.md`
**Beispiel:** `KA02_BG12_2025_2026_VERSION1_lsg.md`

- Selbe Struktur wie `_aufg.md`, aber mit Suffix `_lsg`
- Enthaelt: Aufgabenstellung + Musterloesung + Erwartungshorizont + Bewertungsraster
- Lehrkraftfassung (vertraulich)
- Dieselben Artefakt-Verweise wie die `_aufg`-Variante

### F) Klassenarbeit-HTML-Export (.html)
**Format Aufgaben:** `KA{KANummer}_{Zielgruppe}_{Schuljahr}_{Version}_aufg.html`
**Format Loesung:** `KA{KANummer}_{Zielgruppe}_{Schuljahr}_{Version}_lsg.html`

- Fuer jede KA-Markdown-Datei (`*_aufg.md`, `*_lsg.md`) muss eine gleichnamige HTML-Datei existieren.
- Es duerfen keine verwaisten HTML-Dateien ohne passende Markdown-Quelle im Verzeichnis liegen.
- Erzeugung ueber: `python scripts/convert_ka_markdown.py`

## Anwendung

### In der Praxis:
1. Neuer Sachverhalt erstellen (z.B. `Fahrradvermietung`, `Kursplattform`)
2. SQL-Struktur schreiben -> speichern als `{System}_struktur_{Jahr}.sql`
3. SQL-Daten schreiben -> speichern als `{System}_daten_{Jahr}.sql`
4. In Workbench modellieren oder manuell mwb-Datei vorbereiten -> `{System}_{Jahr}.mwb`
5. PNG-Generator ausfuehren -> `{System}_{Jahr}.mwb` -> `{System}_{Jahr}.png`
6. Aufgabenvorlage Schritt-für-Schritt ausfuellen -> `KA0x_{ZG}_{Jahr}_{Version}_aufg.md`
7. Loesung + EH + Raster aus Aufgabe ableiten -> `KA0x_{ZG}_{Jahr}_{Version}_lsg.md`
8. HTML-Exporte fuer Aufgaben- und Loesungsfassung erzeugen -> `KA0x_{ZG}_{Jahr}_{Version}_{aufg|lsg}.html`

### Generator und Validierungen:
- Generatoren pruefen auf `*_struktur_{Jahr}.sql` + `*_daten_{Jahr}.sql`-Paare
- Validierungsskripte pruefen auf eindeutige Benennung innerhalb des Verzeichnisses
- Doppelte Versionen fuer denselben Sachverhalt/Schuljahr werden gekennzeichnet

## Erfolgskriterien
- Alle `.mwb`-Dateien folgen Format `{Systemname}_{Jahr}.mwb`
- Alle SQL-Dumps liegen als Struktur+Daten-Paar vor: `{System}_struktur_{Jahr}.sql` + `{System}_daten_{Jahr}.sql`
- Alle Klassenarbeits-Markdown-Dateien folgen `KA0x_{ZG}_{Jahr}_{Version}_aufg/lsg.md`
- Alle Klassenarbeits-HTML-Dateien folgen `KA0x_{ZG}_{Jahr}_{Version}_aufg/lsg.html`
- Im Verzeichnis `generated/klassenarbeiten` keine veralteten oder abweichenden Namensmuster mehr
- Pflicht-Gates laufen erfolgreich durch

## Fehlerbehandlung
- Datei mit altem Namensmuster gefunden: umbenennen oder loeschen
- Struktur und Daten ungekoppelt: als Paar anlegen
- Version mehrdeutig: Version im Dateinamen klarer numerieren
- Markdown ohne HTML-Paar: `python scripts/convert_ka_markdown.py` ausfuehren
- HTML ohne Markdown-Quelle: verwaiste HTML entfernen oder Quelle wiederherstellen

## LLM-Prompt-Baustein (verbindlich)
"Benennung aller neuen Artefakte in `generated/klassenarbeiten` folgt strikter Konvention: `.mwb`-Dateien als `{System}_{Jahr}.mwb`, SQL-Dumps immer als Struktur+Daten-Paar (`{System}_struktur_{Jahr}.sql` und `{System}_daten_{Jahr}.sql`), KA-Markdown-Dateien als `KA0x_{ZG}_{Schuljahr}_{Version}_aufg/lsg.md`, HTML-Dateien als `KA0x_{ZG}_{Schuljahr}_{Version}_aufg/lsg.html`. Im Verzeichnis gibt es keine Duplikate, keine verwaisten HTML-Dateien und keine gemischten Dumpformate."

## Verknuepfungen
- [KF-ROUTINE-008-separater-sql-3nf-kontext.md](./KF-ROUTINE-008-separater-sql-3nf-kontext.md)
- [KF-ROUTINE-009-eerm-png-generator.md](./KF-ROUTINE-009-eerm-png-generator.md)
- [../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md)
- [../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md)

## Changelog
- 1.0 (11.05.2026): Benennungskonvention eingefuehrt fuer Modelle, SQL-Dumps (Struktur+Daten), und KA-Markdown-Dateien.
- 1.1 (11.05.2026): HTML-Benennung und Pflicht-Paarung (MD/HTML) als verbindliche Regel ergaenzt.
