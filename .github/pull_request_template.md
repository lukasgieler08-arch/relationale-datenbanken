## Ziel

Beschreibe kurz, welches Problem geloest wurde.

## Architektur-Auswirkung

- [ ] Schichten bleiben getrennt (UI/Controller/Model bzw. API/DB)
- [ ] OOP-Prinzipien eingehalten (Kapselung, klare Verantwortlichkeiten)
- [ ] Keine neue Redundanz eingefuehrt

## Sicherheit

- [ ] Keine Secrets im Repo
- [ ] Keine unsicheren Defaults hinzugefuegt
- [ ] Fehlerantworten leaken keine internen Details

## Dokumentation

- [ ] Handbuch aktualisiert (Architektur/Prozess/Routine)
- [ ] Marschplan bei relevanten Aenderungen aktualisiert
- [ ] Changelog/Version angepasst

## Tests und Checks

- [ ] `bash scripts/validate-security.sh`
- [ ] `bash scripts/validate-architecture.sh`
- [ ] `bash scripts/validate-docs.sh`
- [ ] Relevante Laufzeittests (z. B. `bash scripts/test-services.sh`)
