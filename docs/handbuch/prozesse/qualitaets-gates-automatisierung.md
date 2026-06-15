# Prozess: Qualitaets-Gates & Automatisierung

**Version:** 1.0
**Status:** Aktiv
**Gueltig ab:** 25.03.2026

---

## Ziel

Sicherstellen, dass jede Code- oder Doku-Erweiterung automatisiert auf OOP, Erweiterbarkeit, Wartbarkeit, Sicherheit, Wiederverwendbarkeit, Redundanzfreiheit und Dokumentationskonsistenz geprueft wird.

## Pflicht-Gates

1. Security-Gate: `bash scripts/validate-security.sh`
2. Architecture-Gate: `bash scripts/validate-architecture.sh`
3. Documentation-Gate: `bash scripts/validate-docs.sh`

Hinweis Klassenarbeiten/Pruefungen:
- Innerhalb des Documentation-Gates wird zusaetzlich `bash scripts/validate-ka-separate-context.sh` ausgefuehrt.
- Dadurch wird erzwungen, dass Teil B (Modellierung) und Teil C (SQL) didaktisch getrennte Kontexte verwenden.

Alle drei Gates sind lokal und in CI verpflichtend.

## Workflow

1. Aenderung in Feature-Branch durchfuehren
2. Dokumentation automatisch optimieren: `bash scripts/optimize-docs.sh`
3. Lokale Gates ausfuehren
4. PR mit Template-Checklist erstellen
5. CI-Gates muessen gruen sein
6. Review + Merge

## Dokumentations-Autopilot

- Script: `bash scripts/optimize-docs.sh`
- Funktionen:
	- normalisiert Markdown-Dateien (Whitespace, Leerzeilen, konsistente Schritt-Nummerierung)
	- prueft doppelte Ueberschriften als Redundanzsignal
	- validiert die Wohlgeformtheit direkt im Anschluss
- Das Documentation-Gate (`bash scripts/validate-docs.sh`) erzwingt diese Strukturpruefung automatisch.

## Abbruchkriterien

Ein Merge ist zu stoppen, wenn mindestens eines der folgenden Kriterien zutrifft:

- Sicherheitsverstoß (Secret, schwacher Default, Error-Leak)
- Architekturverstoß (Schichtbruch, Encapsulation-Verletzung)
- Doku-Luecke (Code geaendert, Handbuch nicht aktualisiert)

## Messkriterien

- CI-Erfolgsrate der Pflicht-Gates
- Anzahl geblockter Merges durch Gate-Fehler
- Anteil Aenderungen mit aktualisierter Doku

## Changelog

- v1.0 (25.03.2026): Initiale Prozessdefinition fuer automatische Qualitaets-Gates
