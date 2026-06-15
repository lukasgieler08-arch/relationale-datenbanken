# KF-ROUTINE-011: Drei-Versionen-Automatismus fuer Klassenarbeiten

## Metadata
- ID: KF-ROUTINE-011
- Kategorie: kurzfristig
- Status: aktiv
- Version: 1.0
- Gueltig ab: 11.05.2026
- Zielgruppe: Lehrkraefte und Autoren von Klassenarbeiten/Pruefungen
- Abhaengigkeiten:
  - KF-ROUTINE-008-separater-sql-3nf-kontext.md
  - KF-ROUTINE-009-eerm-png-generator.md
  - KF-ROUTINE-010-datei-bezeichnungskonvention.md

## Ziel
Fuer jede Klassenarbeit werden immer drei Versionen gepflegt und erzeugt:
1. VERSION1 fuer den 1. Haupttermin
2. VERSION2 fuer den 2. Nachtermin
3. VERSION3 als Muster/Uebung vorab

Alle Versionen haben denselben Erwartungshorizont (Punkte, Aufgabenstruktur, Zeitrahmen), aber unterschiedliche Aufgabenkontexte und unterschiedliche SQL-Datenquellen.

## Verbindliche Regeln
- Es existieren immer sechs Markdown-Dateien pro Set:
  - `..._VERSION1_aufg.md`, `..._VERSION1_lsg.md`
  - `..._VERSION2_aufg.md`, `..._VERSION2_lsg.md`
  - `..._VERSION3_aufg.md`, `..._VERSION3_lsg.md`
- Pro VERSION ist der Modellierungskontext (Teil B) unterschiedlich.
- Pro VERSION ist der SQL-Kontext (Teil C) unterschiedlich.
- Erwartungshorizont bleibt gleich:
  - Gesamtpunkte
  - Teilstruktur
  - Zeitbudget
  - Kompetenzniveau
- Zu jeder Markdown-Datei existiert eine gleichnamige HTML-Datei.

## Automatismus
Script:
- `scripts/generate-ka-varianten.sh`

Aufruf:
```bash
bash scripts/generate-ka-varianten.sh KA02_BG12_2025_2026
```

Das Script:
1. prueft, ob VERSION1/2/3 in aufg+lsg vorhanden sind,
2. prueft, ob Modell- und SQL-Kontexte nicht doppelt verwendet werden,
3. erzeugt HTML-Exporte,
4. erzeugt/aktualisiert EERM-PNG-Artefakte.

## Erfolgskriterien
- Alle drei Versionen sind vorhanden und vollstaendig (aufg+lsg+html).
- Kontexte von VERSION1/2/3 sind nicht identisch.
- SQL-Artefakte folgen Struktur+Daten-Trennung.
- Pflicht-Gates laufen erfolgreich durch.

## LLM-Prompt-Baustein (verbindlich)
"Erzeuge fuer jede Klassenarbeit drei Versionen (VERSION1/2/3) mit identischem Erwartungshorizont, aber unterschiedlichen Sachverhalten und unterschiedlichen SQL-Kontexten. Nutze die Benennung nach KF-ROUTINE-010 und fuehre den Automatismus ueber `scripts/generate-ka-varianten.sh` aus."

## Verknuepfungen
- [KF-ROUTINE-008-separater-sql-3nf-kontext.md](./KF-ROUTINE-008-separater-sql-3nf-kontext.md)
- [KF-ROUTINE-009-eerm-png-generator.md](./KF-ROUTINE-009-eerm-png-generator.md)
- [KF-ROUTINE-010-datei-bezeichnungskonvention.md](./KF-ROUTINE-010-datei-bezeichnungskonvention.md)

## Changelog
- 1.0 (11.05.2026): Drei-Versionen-Automatismus fuer Haupttermin, Nachtermin und Musterfassung eingefuehrt.
