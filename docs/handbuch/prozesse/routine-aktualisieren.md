# PROZESS: Routine aktualisieren & Wartung

**Dokumentversion:** 1.0
**Ziel:** Systematische Aktualisierung und Wartung bestehender Routinen
**Zielgruppe:** Dokumentatoren, Tech Leads, Process Owner

---

## 🎯 Überblick

Dieser Prozess regelt die **Aktualisierung und Wartung existierender Routinen** - sei es durch kleine Optimierungen, größere Refactorings oder Archivierungen.

**Vier Arten von Updates:**
1. 🟢 **Minor Updates** (v1.1, v1.2) - Kleine Verbesserungen
2. 🟠 **Major Updates** (v2.0) - Strukturelle Änderungen
3. 🔴 **Archivierung** - Routine nicht mehr aktuell
4. 🔵 **Deprecation** - Transition zu neuer Routine

---

## 📋 Entscheidungswerk: Welche Art von Update?

### Frage 1: Warum im Update?

| Grund | Beispiel | Update-Typ |
|-------|---------|-----------|
| **Tippfehler/Formatierung** | Typo im Text | Minor (v1.1) |
| **Einzelnen Schritt optimiert** | "2h" → "1h Zeitaufwand" | Minor (v1.1) |
| **Workflow angepasst** | GitHub statt GitLab | Minor (v1.1) |
| **Neuen Tool-Namen** | "Slack" → "Teams" | Minor (v1.1) |
| **Mehrere Schritte ändern** | Ganz neues Vorgehen | Major (v2.0) |
| **Routine komplett refaktorn** | New Layout/Structure | Major (v2.0) |
| **Routine nicht mehr nötig** | Tool abgelöst, Software deprecated | Archivierung |
| **Wird von neuer ersetzt** | Alte Methode → besser Methode | Deprecation |

### Frage 2: Wie umfangreich?

```
Umfang klein (1-2 Sätze geändert)?
  ↓ Minor Update (v1.1)

Umfang mittel (mehrere Punkte/Schritte)?
  ↓ Major Update (v2.0)

Umfang groß (völlig neuer Prozess)?
  ↓ Major Update (v2.0) oder Neue Routine?
```

---

## 🟢 Minor Updates (v1.1, v1.2, etc.)

**Für:** Kleine Verbesserungen, Tippfehler, Klarstellungen

### Schritt 1: Änderung planen

1. **Begründung definieren:**
   ```
   Warum: [Grund für Änderung]
   Was: [Konkrete Änderung]
   Impact: [Wie affects es Benutzer?]
   ```

2. **Scope definieren:**
   - Nur Fehlerkorrektur (kein funktionales Change)?
   - Alle Schritte bleiben gleich?
   - Kein Impact auf Abhängigkeiten?

### Schritt 2: Änderung machen

```bash
# Feature Branch
git checkout -b routine/KF-ROUTINE-001-optimization

# Datei bearbeiten
code docs/handbuch/routinen/kurzfristig/KF-ROUTINE-001.md

# Änderung: Tippfehler, besser Formulierung, Klarstellung
# ...
```

**Was darf nicht geändert werden:**
- ❌ Routine-ID (bleibt same)
- ❌ Grundlegende Ziele/Schritte
- ❌ Abhängigkeiten (außer Klarstellungen)

### Schritt 3: Versionsnummer erhöhen

```markdown
## Changelog

| Version | Datum | Autor | Änderungen |
|---------|-------|-------|-----------|
| 1.0 | 15.03.2026 | Alice | Initial release |
| 1.1 | 23.03.2026 | Bob | [CHANGE-DESCRIPTION] |
```

### Schritt 4: Git Commit

```bash
git add docs/handbuch/routinen/kurzfristig/KF-ROUTINE-001.md

git commit -m "MINOR UPDATE: KF-ROUTINE-001 v1.1
- Was: [Beschreibung]
- Grund: [Warum war Update nötig?]"

git push origin routine/KF-ROUTINE-001-optimization
```

### Schritt 5: Pull Request

**Title:** `MINOR UPDATE: KF-ROUTINE-001 - [Kurzbeschreibung]`

**Description:**
```markdown
## Minor Update für [ROUTINE-ID]

### Was wurde geändert?
- Punkt 1
- Punkt 2

### Grund?
[Warum war das Update nötig?]

### Versionsprung
v1.0 → v1.1

### Impact
- Keine neuen Abhängigkeiten
- Abwärtskompatibel
- Schnelle Merge möglich
```

### Schritt 6: Fast-Track Approval

Minor Updates brauchen:
- ✅ Selbst-Review (Typos, Format)
- ✅ 1 Reviewer (wenn Inhalt-Änderung)
- ↯ Kein großer Approval-Prozess nötig

---

## 🟠 Major Updates (v2.0, v3.0)

**Für:** Größere Änderungen, neue Struktur, neue Anforderungen

### Schritt 7: Änderung planen

1. **Detaillierte Analyse:**
   ```
   Aktuelles Problem: [Was ist suboptimal?]
   Neue Lösung: [Wie soll es aussehen?]
   Kosten/Nutzen: [Ist der Aufwand wert?]
   Abhängigkeits-Impact: [Welche anderen Routinen ändern sich?]
   Migrationsplan: [Wie gehen alte Benutzer über?]
   ```

2. **Abhängigkeits-Analyse:**
   - Welche anderen Routinen verweisen auf diese?
   - Müssen die auch updated werden?
   - Gibt es inkompatible Änderungen?

### Schritt 8: Design-Document erstellen

Schreibe ein kurzes Design-Dokument:

```markdown
## Design: [ROUTINE-ID] v2.0 Update

### Motivation
[Warum ist Major Update nötig?]

### Neuer Prozess
[Wie soll es ablaufen?]

### Unterschiede zu v1.0
...

### Abhängigkeiten betroffen
- ROUTINE-X: [Auswirkung]
- ROUTINE-Y: [Auswirkung]

### Migrationsplan
- Phase 1: v1.0 + v2.0 parallele Unterstützung
- Phase 2: Phase-out v1.0
- Phase 3: v1.0 löschen
```

### Schritt 9: Änderungen machen

```bash
git checkout -b routine/KF-ROUTINE-001-v2-redesign

# Größere Umstrukturierung
# - Neue Schritte
# - Andere Erfolgskriterien
# - Neue Fehlerbehandlung
# etc.
```

### Schritt 10: Update Versionsnummer & Changelog

```markdown
## Changelog

| Version | Datum | Autor | Änderungen |
|---------|-------|-------|-----------|
| 1.0 | 15.03.2026 | Alice | Initiale Version |
| 2.0 | 23.03.2026 | Bob | **Major Redesign** - siehe unten |

### v2.0 - Major Redesign
[Ausführliche Beschreibung aller Änderungen]

#### Breaking Changes
- Schritt 1 komplett neu
- Erfolgs-Kriterium geändert

#### Migrationsanleitung
[Wie gehen alte Benutzer über?]
```

### Schritt 11: Git Commit & PR

```bash
git commit -m "MAJOR UPDATE: KF-ROUTINE-001 → v2.0
- Breaking changes: [Liste]
- Grund: [Warum redesign?]
- Migrations-Info: Siehe CHANGELOG"

git push origin routine/KF-ROUTINE-001-v2-redesign
```

**Title:** `MAJOR UPDATE: KF-ROUTINE-001 v2.0 - [Redesign-Grund]`

### Schritt 12: Review & Genehmigung

Major Updates brauchen:
- ✅ Detailliertes Design-Review
- ✅ Mindestens 2 Reviewer
- ✅ Abhängigkeits-Check (Andere Routinen OK?)
- ✅ Tech-Lead Approval
- ✅ Falls Breaking: Kommunikation an Nutzer

---

## 🔴 Archivierung (Routine wird obsolet)

**Für:** Routine ist nicht mehr aktuell, sollte nicht mehr verwendet werden

### Schritt 13: Entscheiden

```
Ist die Routine noch relevant?
  ├─ JA → Aktualisieren (Minor/Major)
  └─ NEIN → Archivieren

Gibt es Abhängigkeiten?
  ├─ JA → Erst Alternative finden/erstellen
  └─ NEIN → Löschen oder Archivieren
```

### Schritt 14: Abhängigkeiten rerouten

```
1. Alle Routine finden, die referenzieren
2. Diese auf neue Routine zeigen lassen
3. Reviews durchführen
```

### Schritt 15: Archiviert-Status setzen

```markdown
## ARCHIVIERT - Nicht mehr verwenden

**Status:** 🔴 Archiviert (23.03.2026)
**Grund:** [Warum archiviert?]
**Alternative:** 🔗 [KF-ROUTINE-002: Neue Methode](link)
**Letzte aktive Version:** v1.0 (15.03.2026)

---

## ⚠️ VERWENDUNG EINSTELLEN

Diese Routine ist nicht mehr aktuell. Bitte nutze stattdessen:
→ [KF-ROUTINE-002: Neue Methode](link)
```

### Schritt 16: Datei behalten (nicht löschen!)

```bash
# Diese Datei NICHT löschen!
# Grund: Historie, Backlinks, Referenzen

# Stattdessen: Datei in archiv-Order verschieben (optional)
mv docs/handbuch/routinen/kurzfristig/KF-ROUTINE-001.md \
   docs/handbuch/routinen/archiv/KF-ROUTINE-001-ARCHIV.md
```

### Schritt 17: Index updaten

```bash
# Aus Übersichten entfernen
# Aber in Archiv-Übersicht hinzufügen
```

---

## 🔵 Deprecation (Transition zu neuer Routine)

**Für:** Alte Routine wird durch neue Routine ersetzt

### Schritt 18: Neue Routine erstellen

Schaffe die bessere Version (KF-ROUTINE-002) zuerst.

### Schritt 19: Alte Routine mit Deprecation-Notice

```markdown
## ⚠️ DEPRECATED - Verwende stattdessen v2.0

**Status:** 🟡 Deprecated (23.03.2026)
**Bis:** 30.06.2026 (veraltete Unterstützung bis daher)
**Nachfolger:** 🔗 [KF-ROUTINE-002: New Method v2.0](link)

### Migration Guide

Alte Routine → Neue Routine:
- Schritt A → Schritt 1
- Schritt B → Schritt 2
- ...

[Detaillierte Migrationsanleitung]
```

### Schritt 20: Deprecation-Timeline

**Phase 1: Ankündigung (Woche 1)**
- Deprecation-Hinweis hinzufügen
- Via Email/Slack ankündigen
- 2 Wochen Lead-Time

**Phase 2: Parallel-Support (Wochen 2-4)**
- Beide Versionen aktiv
- Migrationsunterstützung
- Training anbieten

**Phase 3: Support-Modus (Wochen 5-8)**
- Alte Version noch unterstützt
- Aber nur Bug-Fixes
- Keine neuen Features

**Phase 4: Removal (Woche 9+)**
- Alte Routine löschen oder archivieren
- Nur nach vollständiger Migration

---

## 🔍 Priorisierung & Planung

**Wann sollten Routinen aktualisiert werden?**

| Priorät | Bedingung | Dauer | Beispiel |
|---------|-----------|-------|---------|
| 🔴 SOFORT | Sicherheit/Fehler | < 1h | "Schritt ist unsicher" |
| 🟠 DIESE WOCHE | Tool/Prozess geändert | 2-4h | "GitHub → GitHub Enterprise" |
| 🟡 DIESEN MONAT | Optimierung | 4-8h | "Schritt dauert zu lange" |
| 🟢 DIESES QUARTAL | Refactoring | Variabel | "Neue beste Praxis" |

---

## 📊 Update-Metriken

**Track diese Metriken:**

- `Durchschnittliches Alter einer Routine` → Ziel: < 12 Monate
- `% veraltete Routinen` → Ziel: < 5%
- `Update-Häufigkeit` → Ziel: > 2 Updates/Quartal
- `Zeit bis Bugfix` → Ziel: < 1 Woche

---

## 💡 Best Practices

### Beim Aktualisieren
- ✅ Versionsnummer korrekt erhöhen
- ✅ Changelog detailliert schreiben
- ✅ Abhängigkeiten überprüfen
- ✅ Review-Prozess nutzen
- ✅ Nutzer ggf. informieren (bei Breaking Changes)

### Was NICHT tun
- ❌ Routine-ID ändern (macht alles kaputt!)
- ❌ Old Versions komplett löschen (Backup!)
- ❌ Breaking Changes ohne Migration-Plan
- ❌ Größere Änderungen ohne Changelog
- ❌ Archivierung ohne Alternative

---

## 🆘 Häufige Probleme

| Problem | Lösung |
|---------|--------|
| Zu viele Updates geplant | Priorisieren, Batching |
| Abhängigkeiten-Chaos | Dependency-Matrix nutzen |
| Update-Konflikte | Koordination, Branching-Strategie |
| Alte Version noch verwendet | Migrationsplan / Deprecation |

---

## 📞 Support & Fragen

**Bei Fragen zum Update-Prozess:**
→ Frag deinen Tech-Lead oder review die [ARCHITEKTUR.md](../ARCHITEKTUR.md)

---

**Version:** 1.0
**Letzte Aktualisierung:** 23.03.2026
