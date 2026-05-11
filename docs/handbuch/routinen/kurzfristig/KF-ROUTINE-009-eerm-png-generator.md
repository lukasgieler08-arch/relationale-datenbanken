# KF-ROUTINE-009: EERM-PNG-Generator fuer SQL-Kontexte

## Metadata
- ID: KF-ROUTINE-009
- Kategorie: kurzfristig
- Status: aktiv
- Version: 1.0
- Gueltig ab: 11.05.2026
- Zielgruppe: Lehrkraefte und Autoren von Klassenarbeiten/Pruefungen
- Abhaengigkeiten:
  - KF-ROUTINE-008-separater-sql-3nf-kontext.md

## Ziel
Sicherstellen, dass fuer den SQL-Teil (Teil C) eine einbettbare Modellgrafik als PNG verfuegbar ist, auch wenn kein manueller Workbench-Export vorliegt.
Die Generatorgrafik wird aus dem SQL-Dump gerendert (Tabellen + FKs), damit sie didaktisch brauchbar ist.
Die Linien werden so geroutet, dass unbeteiligte Entitaetstypen umfahren werden und nicht durchlaufen werden.
Die Generierung ist auf A4-Druckbarkeit ausgelegt (Portrait-Layout, Entitaetstypen bevorzugt untereinander).

## Vorbedingungen
- Teil-C-Modell als `{Systemname}_{Jahr}.mwb` liegt im Verzeichnis `generated/klassenarbeiten`.
- SQL-Teil C liegt getrennt vor als `{Systemname}_struktur_{Jahr}.sql` und `{Systemname}_daten_{Jahr}.sql`.
- Python 3 ist verfuegbar.

## Schritte
1. Ein-Befehl-Workflow ausfuehren:
  - `bash scripts/generate-ka-eerm-assets.sh`
  - optional mit Ueberschreiben bestehender PNGs: `bash scripts/generate-ka-eerm-assets.sh --force`
  - enthaltene PNG-Layout-Parameter: `--a4-portrait --max-columns 2`
2. Ausgabe pruefen:
  - Fuer jede `{Systemname}_struktur_{Jahr}.sql` mit passender Daten-Datei existiert danach `{Systemname}_{Jahr}.png`.
3. Bei Bedarf manuell in zwei Schritten ausfuehren:
  - `python3 scripts/plugins/eerm_grafik_generator/generate_eerm_png.py --input-dir generated/klassenarbeiten`
  - `python3 scripts/plugins/eerm_grafik_generator/embed_eerm_png_reference.py --markdown-dir generated/klassenarbeiten`
4. In Aufgaben-/Lehrkraftvorlage Grafik einbetten (Template-Ebene):
  - `![EERM Teil C](../../../generated/klassenarbeiten/{Systemname}_{Jahr}.png)`
5. Pflicht-Gates ausfuehren:
   - `bash scripts/validate-security.sh`
   - `bash scripts/validate-architecture.sh`
   - `bash scripts/validate-docs.sh`

## Erfolgskriterien
- PNG-Datei fuer Teil-C-Modell vorhanden.
- Einbettung im jeweiligen Dokument vorhanden.
- PNG ist aus dem SQL-Schema abgeleitet (nicht nur Platzhalter).
- Diagramm ist auf A4 lesbar (keine ueberbreiten Reihen, Entitaeten bevorzugt untereinander).
- Pflicht-Gates laufen erfolgreich durch.

## Fehlerbehandlung
- Kein `{Systemname}_{Jahr}.mwb` gefunden:
  - Dateibenennung und Ablagepfad korrigieren.
- PNG nicht erstellt:
  - Pruefen, ob sowohl `{Systemname}_struktur_{Jahr}.sql` als auch `{Systemname}_daten_{Jahr}.sql` vorhanden sind.
  - Skript-Fehlermeldung pruefen und Dateirechte kontrollieren.
- Manuelle Workbench-Grafik vorhanden:
  - Diese darf die Generatorgrafik ersetzen (Workbench bleibt bevorzugt).
- Native .mwb-Designerdatei benoetigt:
  - Diese wird in Workbench gepflegt; der PNG-Generator erzeugt keine native Designerbearbeitung.

## LLM-Prompt-Baustein (verbindlich)
"Wenn fuer Teil C keine Workbench-Grafik vorliegt, erzeuge automatisch eine PNG-Grafik aus den vorhandenen SQL-Artefakten (`*_struktur_*.sql` + `*_daten_*.sql`) ueber das Generator-Plugin und binde die Grafik in Aufgaben- und Lehrkraftvorlage ein."

## Verknuepfungen
- [KF-ROUTINE-008-separater-sql-3nf-kontext.md](./KF-ROUTINE-008-separater-sql-3nf-kontext.md)
- [../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-AUFGABEN-ARTEFAKTE-BPE6-BPE5.md)
- [../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md](../../templates/KLASSENARBEIT-TEMPLATE-LOESUNG-ERWARTUNGSHORIZONT-BPE6-BPE5.md)

## Changelog
- 1.0 (11.05.2026): Routine fuer automatisierte Bereitstellung von Teil-C-Modellgrafiken eingefuehrt.
