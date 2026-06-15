# PROZESS: Redundanz-Management

**Dokumentversion:** 1.0
**Ziel:** Systematische Erkennung und Elimination von Redundanzen
**Zielgruppe:** Prozess-Manager, Reviewers, Architekten

---

## 🎯 Überblick

Redundanzen (doppelte oder überlappende Routinen) sind ein häufiges Problem in Wissensdatenbanken. Dieses Prozess verhindert proaktiv und beseitigt reaktiv Redundanzen.

**Ziele:**
- ✅ Redundanzen **verhindern** (vor Erstellung)
- ✅ Redundanzen **erkennen** (regelmäßig)
- ✅ Redundanzen **elimnieren** (kontrolliert)
- ✅ Abhängigkeiten **korrigieren** (bei Merge)

---

## 🚨 Arten von Redundanzen

### Type A: Exakte Duplikate
```
Routine A: "Täglich Tests schreiben"
Routine B: "Täglich Tests schreiben"  ← EXAKTE KOPIE!

Lösung: Eine löschen, Abhängigkeiten umleiten
```

### Type B: Teilverlappung
```
Routine A: "Täglich Code Review + Tests schreiben"
Routine B: "Täglich Tests schreiben"

Lösung: B als Subprozess in A einbinden oder zusammenführen
```

### Type C: Funktional identisch (unterschiedliche Darstellung)
```
Routine A: "Monatlicher System-Audit"
Routine B: "Monatliche System-Überprüfung"  ← Formal unterschiedlich, inhaltlich gleich

Lösung: Zusammenführen unter einheitlichem Namen
```

### Type D: Übernommene Schritte
```
Routine A hat 5 Schritte
Routine B hat die gleichen 5 Schritte + 2 weitere

Lösung: B referenziert A als Abhängigkeit, nicht Kopie
```

---

## 📋 Redundanz-Erkennung (Prozess)

### Schritt 1: Verdacht identifizieren

**Wann sollte man Redundanzen prüfen?**
- ✅ Vor Erstellung einer neuen Routine
- ✅ Im Review-Prozess
- ✅ Bei monatlichen Audits
- ✅ Bei Änderungen/Updates

**Verdacht-Indikatoren:**
- Ähnliche Namen/IDs
- Überlappende Keywords
- Ähnliche Ziele
- Überlappende Schritte

### Schritt 2: Ähnliche Routinen finden

**Methode 1: Manuell suchen**
```bash
# Nach Keyword suchen
grep -ri "test" docs/handbuch/routinen/

# Nach Pattern suchen
grep -ri "täglich" docs/handbuch/routinen/kurzfristig/

# Dateiliste anschauen
ls -la docs/handbuch/routinen/*/
```

**Methode 2: Dependency-Analyse**
```
Wenn Routine A → B → C zeigt,
könnte Routine C auch direkt von A aufgerufen werden?
= Potenzielle Redundanz
```

**Methode 3: Metadaten-Analyse**
- Gleiches Ziel, unterschiedliche Implementierung?
- Gleicher Zeitaufwand, unterschiedliche Inhalte?
- Gleicher Verantwortlicher?

### Schritt 3: Vergleich durchführen

**Vergleich-Matrix erstellen:**

```markdown
## Verdacht: ROUTINE-001 vs ROUTINE-003

| Aspekt | ROUTINE-001 | ROUTINE-003 | Redundanz? |
|--------|------------|------------|-----------|
| Ziel | "Tests schreiben" | "Tests schreiben" | 🔴 JA |
| Häufigkeit | täglich | täglich | 🔴 JA |
| Schritte | A,B,C | A,B,C,D | 🟡 TEILWEISE |
| Zeitaufwand | 30 Min | 45 Min | 🟡 ÄHNLICH |
| Abhängigkeiten | X,Y | Y,Z | 🟡 TEILWEISE |

**Fazit:** 70-80% Redundanz → Zusammenführung empfohlen
```

### Schritt 4: Schweregrad klassifizieren

| Grad | Beschreibung | Beispiel | Aktion |
|------|-------------|---------|--------|
| 🔴 **KRITISCH** | >80% Overlap, exakte Duplikate | Routine identisch kopiert | Sofort eliminieren |
| 🟠 **HOCH** | 60-80% Overlap, gleiche Ziele | Sehr ähnliche Inhalte (1-2 Unterschiede) | Diese Woche eliminieren |
| 🟡 **MITTEL** | 40-60% Overlap, Test-Redundanzen | Teile sind doppelt, Teile unterschiedlich | Nächste Sprint optimieren |
| 🟢 **NIEDRIG** | <40% Overlap, unterschiedliche Ziele | Erweit erung bestehender Routine | Dokumentieren, beobachten |

---

## 🛠️ Redundanz-Elimination (Prozess)

### Option 1: LÖSCHEN (bei exakten Duplikaten)

**Wenn:** Routine A und Routine B sind identisch

**Schritte:**
1. Alleeabhängigkeiten sammeln (Welche Routinen brauchen B?)
2. Die abhängigen Routinen updaten (statt B → A)
3. Changelog in A hinzufügen: "Mit ROUTINE-B zusammengeführt (Datum)"
4. Routine B löschen
5. Git Commit mit Begründung

**Beispiel Commit-Message:**
```
REDUNDANZ-FIX: Lösche KF-ROUTINE-005
Grund: Exakte Duplikat von KF-ROUTINE-003
Abhängigkeiten: Umgeleitet zu KF-ROUTINE-003
```

### Option 2: ZUSAMMENFÜHREN (bei Teiloverlap)

**Wenn:** Routine A und B haben Teile gemeinsam

**Schritte:**
1. Entscheiden: Welche Routine ist "Hauptroutine"?
2. Unterschiede analysieren und zusammenführen
3. Merged-Routine bekommt Name mit Kontext
4. Alte Routinen als "Deprecated" markieren
5. Abhängigkeiten umleiten

**Beispiel:**

```markdown
# KF-ROUTINE-003: Tests schreiben & Code Review

## Vorgänger (zusammengeführt)
- ~~KF-ROUTINE-001: Tests schreiben~~
- ~~KF-ROUTINE-005: Code Review durchführen~~

## Changelog
- v1.0: Von separat zu integriert
  - KF-ROUTINE-001 & KF-ROUTINE-005 zusammengeführt
  - Redundanz eliminiert
```

### Option 3: REFAKTORIEREN (bei funktionalen Überlappungen)

**Wenn:** Routine A und B haben ähnliche Ziele, unterschiedliche Implementierung

**Entscheidungsfragen:**
1. Ist eine Implementierung besser/aktueller?
2. Können wir eine als Template der anderen nutzen?
3. Sollte es nur eine "offizielle" Version geben?

**Vorgehen:**
1. Best-Practice-Version identifizieren
2. Als Standard-Version verwenden
3. Alternative als "Variant" dokumentieren
4. Beide mit Referenzen verlinken
5. Abhängigkeiten prüfen

---

## 📊 Redundanz-Matrix (Auditdokument)

**Beispiel-Struktur zum Tracken:**

```yaml
# redundanz-matrix.yaml
audit_date: 2026-03-23
auditor: Team
status: "in_progress"

findings:
  - id: RED-001
    routine_a: "KF-ROUTINE-001"
    routine_b: "KF-ROUTINE-005"
    overlap: 90
    type: "exakte_duplikate"
    severity: "KRITISCH"
    recommendation: "ROUTINE-005 löschen"
    status: "zu_prüfen"

  - id: RED-002
    routine_a: "MF-ROUTINE-001"
    routine_b: "MF-ROUTINE-003"
    overlap: 65
    type: "teilverlappung"
    severity: "HOCH"
    recommendation: "zusammenführen"
    status: "zu_prüfen"

summary:
  total_redundanzen: 2
  kritisch: 1
  hoch: 1
  mittel: 0
  niedrig: 0
  redundanzen_quote: 8.3  # (2 aus 24 Routinen)
  action_required: true
```

---

## 🔄 Monatliche Redundanz-Audits

### Audit-Checkliste

**Monatlich durchführen:**
- [ ] Alle neuen Routinen auf Redundanzen prüfen
- [ ] Ähnliche Routine-Namen flaggen
- [ ] Abhängigkeits-Graph visualisieren
- [ ] "Alte" Routinen überprüfen (aktuell noch relevant?)
- [ ] User-Feedback zum Durcheinander sammeln

**Quartallich durchführen:**
- [ ] Vollständige Redundanz-Analyse aller Routinen
- [ ] Veraltete Routinen archivieren
- [ ] Redundanz-Matrix aktualisieren
- [ ] Report erstellen & mit Team diskutieren

**Jährlich durchführen:**
- [ ] Großes Refactoring-Projekt planen
- [ ] Architektur überprüfen
- [ ] Kategorie-Struktur überprüfen (noch sinnvoll?)
- [ ] Neue Strukturierungsideen evaluieren

---

## 💬 Kommunikation bei Redundanz-Elimination

### Wenn Routine gelöscht/gemergt wird:

**An alle Beteiligten kommunizieren:**
```
Liebe Kolleginnen und Kollegen,

Redundanz-Vereinheitlichung: ROUTINE-XXX wird archiviert

Grund: 95% Redundanz mit ROUTINE-YYY identifiziert

Auswirkung: Wenn Sie ROUTINE-XXX verwendet haben, nutzen Sie ab sofort ROUTINE-YYY

Migrationshilfe:
- Video-Tutorial: [link]
- Support: [email/channel]
- Fragen? Kommentar hier hinterlassen

Changelog: Siehe [link zu gemergte Routine]

Danke für Verständnis!
```

---

## 🚀 Automatisierte Redundanz-Erkennung

**Zukünftige Erweiterungen:**

```python
# Pseudocode für Skript
def find_redundancies():
    routines = load_all_routines()

    for i, routine_a in enumerate(routines):
        for routine_b in routines[i+1:]:
            similarity = calculate_similarity(routine_a, routine_b)

            if similarity > 0.8:
                flag_redundancy(routine_a, routine_b, similarity)

    return redundancy_report()
```

---

## ⚠️ Häufige Fehler

| Fehler | Problem | Lösung |
|--------|---------|--------|
| Zu aggressive Elimination | Nützliche Varianten werden gelöscht | Vor Löschung Review durchführen |
| Review-Prozesse ignorieren | Redundanzen entstehen trotzdem | Checkliste im Review-Prozess |
| Abhängigkeiten nicht angepasst | Dead Links nach Eliminierung | Alle Verweise vor Löschung checken |
| Keine Dokumentation der Entscheidung | Später wird gleiche Redundanz neu erstellt | Changelog & Commit-Message nutzen |

---

## 📈 Metriken & Erfolgskriterien

**Track diese Metriken:**
- `Redundanz-Quote` = (Redundante Routinen / Gesamt-Routinen) × 100
  - Ziel: < 5%
- `Durchschnittliche Overlap` = Ø Ähnlichkeit ähnlicher Routinen
  - Ziel: < 10%
- `Zeit bis Elimination` = Von Erkennung bis Löschung
  - Ziel: < 2 Wochen

---

## 📞 Eskalation & Support

**Fragen bei:** [Process Owner / Team Lead]
**Anfragen-Kanal:** [Email / Slack / Issue]
**Escalation:** Wenn sich Teams nicht einigen können

---

**Version:** 1.0
**Letzte Aktualisierung:** 23.03.2026
