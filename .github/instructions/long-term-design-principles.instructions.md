---
applyTo: "src/**/*.java,services/python-api/**/*.py,webapp/public/**/*.{js,php},docs/handbuch/**/*.md,scripts/**/*.sh"
description: "Use when implementing or modifying source code, scripts, or handbook docs to enforce OOP, maintainability, security, reusability, and documentation consistency."
---

# Long-Term Design Principles

## Ziel

Jede Aenderung muss Architektur, Wartbarkeit, Sicherheit und Dokumentation verbessern oder mindestens erhalten.

## Checkliste je Aenderung

1. OOP/Kapselung: keine Leaks interner mutable Datenstrukturen.
2. Erweiterbarkeit: klare Schichten und stabile Schnittstellen.
3. Wartbarkeit: keine toten Pfade, keine doppelte Logik, selbsterklaerende Namen.
4. Sicherheit: keine Secrets und keine internen Fehlerdetails in externen Antworten.
5. Redundanzfreiheit: bestehende Komponenten vor Neucode wiederverwenden.
6. Dokumentation: Handbuch und Marschplan bei relevanten Aenderungen aktualisieren.

## Abschlussregel

Vor Abschluss immer die drei Projektvalidierungen ausfuehren:
- `bash scripts/validate-security.sh`
- `bash scripts/validate-architecture.sh`
- `bash scripts/validate-docs.sh`
