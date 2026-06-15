# BEISPIEL: KF-ROUTINE-001 - Tägliche Code-Review Vorbereitung

**Dies ist ein dokumentiertes Beispiel einer kurztristigen Routine.**
**Nutze dies als Referenz beim Erstellen eigener Routinen!**

---

## KF-ROUTINE-001: Tägliche Code-Review Vorbereitung

### Metadata

| Feld | Wert |
|------|------|
| **ID** | KF-ROUTINE-001 |
| **Name** | Tägliche Code-Review Vorbereitung |
| **Kategorie** | `kurzfristig` |
| **Häufigkeit** | täglich (jeden Morgen) |
| **Zeitaufwand** | 15-20 Minuten |
| **Verantwortlicher** | Entwickler-Team |
| **Sichtbarkeit** | öffentlich |
| **Status** | 🟢 Aktiv |
| **Version** | 1.0 |
| **Erstellt am** | 23.03.2026 |
| **Letzte Aktualisierung** | 23.03.2026 |

---

## 🎯 Ziel & Überblick

**Warum existiert diese Routine?**

Diese Routine bereitet den Arbeitstag vor durch Überprüfung offener Code-Reviews. Ziel ist es, Blockaden früh zu identifizieren und Feedback rechtzeitig zu geben.

**Nutzen & Impact:**
- Gleichmäßiges Feedback an Kollegen
- Keine Reviews werden übersehen
- Schnellere Merge-Zyklen
- Team-Synchronisation

---

## 📋 Vorbedingungen & Kontext

**Was muss vorhanden sein?**

- Zugriff auf GitHub/GitLab Repository
- Code-Editor oder Web-Interface
- 15-20 Minuten Zeit am Morgen
- Internetverbindung

**Abhängigkeiten:**
- 🔗 [KF-ROUTINE-002: Git-Status überprüfen](KF-ROUTINE-002-git-status.md) (Must-Have)
  - Muss vor dieser Routine durchgeführt werden

---

## 🔧 Schritte (Standard-Workflow)

**Schritt 1: Repository-Status überprüfen**
- Öffne das Projekt-Repository (z.B. GitHub)
- Navigiere zum Tab "Pull Requests"
- Filtere auf "Review requested" oder "Needs review"
- Notiere die Anzahl ausstehender Reviews

**Schritt 2: Open PRs durchschauen**
- Durchlaufe alle PRs, die auf dein Review warten
- Für jeden PR:
  - [ ] Titel & Beschreibung lesen (Was wird geändert?)
  - [ ] Status-Checks anschauen (Alles green?)
  - [ ] Bedenkenswerte Files mit rot markieren
  - [ ] Notiere: "Heute reviewen" oder "Später reviewen"

**Schritt 3: Prioritäten setzen**
- **DRINGEND:** PRs, die andere blockieren →  Heute vor Mittag review
- **WICHTIG:** PRs für kritische Features → Heute irgendwann
- **NORMAL:** Cosmetic Changes → Diese Woche

**Schritt 4: Termin planen**
- Reserviere 30-60 Minuten für deine dringendsten Reviews
- Blockcale im Kalender setzen
- Team Slack benachrichtigen: "Starte heute mit Reviews"

**Schritt 5: Checklist erstellen**
- Schreibe diese neuen PRs in deine Tagsüber-Todo-Liste:
  ```
  [ ] PR-123: Feature X review
  [ ] PR-124: Bugfix Y review
  ```

---

## ✅ Erfolgskriterien

**Diese Routine ist erfolgreich abgeschlossen, wenn:**

- [ ] Alle offenen Review-Anfragen wurden überprüft ✓
- [ ] Prioritäten wurden für jeden PR gesetzt ✓
- [ ] Blockierende PRs wurden identifiziert ✓
- [ ] Termin für Review-Session ausgewählt ✓
- [ ] Keine überraschenden kritischen Issues ausstehen ✓

**Metriken:**
- Durchschnittliche Zeit: ≤ 20 Minuten
- % PRs mit festgelegtem Review-Termin: ≥ 80%
- Keine übersehenen dringenden Reviews

---

## ⚠️ Fehlerbehandlung & Edge Cases

**Häufige Probleme:**

| Fehler | Symptom | Lösungsansatz |
|--------|---------|--------------|
| Zu viele offene reviews | > 10 PRs warten | Priorisieren, alte PRs ansprechen |
| Status-Checks sind rot | PR kann nicht gemergt werden | PR-Autor informieren, blockiert |
| Kein Zugriff auf Repo | GitHub-Fehler | IT kontaktieren, Cache leeren |
| Nicht genug Zeit | Nur 5 Min verfügbar | Quick-Scan (nur Titel/Status) |
| Review-List nicht aktuell | Das Dashboard zeigt alte Daten | Browser-Cache leeren (F5) |

---

## 📤 Ausgaben & Ergebnisse

**Was ist das Resultat dieser Routine?**

1. **Priorisierte Review-Liste**
   - Wo: Local Taskboard / Notion / Post-it
   - Format: Nummeriert nach Priorität
   - Beispiel:
     ```
     DRINGEND:
     1. PR-123 (Team-Member blockiert!)
     2. PR-124 (Critical-Bug-Fix)

     HEUTE:
     3. PR-125 (Feature-Implementation)

     DIESE WOCHE:
     4. PR-126 (Code-Cleanup)
     ```

2. **Notizen für komplexe PRs**
   - Wo: PR-Comments (Fragen) oder Local Notes
   - Format: Alle Fragen/Concerns notiert
   - Beispiel: "PR-123: Warum wurde `util.js` geändert?"

3. **Blockade-Report (falls nötig)**
   - Wo: Slack / Email an Team Lead
   - Format: "Die folgenden PRs blockieren andere"
   - Beispiel: "@TeamLead PR-100 blockiert PR-101"

---

## 📚 Ressourcen & Referenzen

**Hilfreich beim Durchführen:**

- 📖 [GitHub Pull Request Guide](https://docs.github.com/en/pull-requests)
- 🎥 [Code Review Best Practices](https://example.com/video)
- 👥 Team Slack Channel: `#code-reviews`

---

## 🔗 Verknüpfungen & Kontext

**Verwandte Routinen:**

- 🔗 [KF-ROUTINE-002: Git-Status überprüfen](KF-ROUTINE-002-git-status.md) (Vorbedingung)
- 🔗 [KF-ROUTINE-003: Code-Review durchführen](KF-ROUTINE-003-code-review.md) (Nachgelagert)
- 🔗 [MF-ROUTINE-001: Monatlicher Code-Quality Audit](../mittelfristig/MF-ROUTINE-001-quality-audit.md) (Verwandt)

**Projekt-Kontext:**
- Projekt: Volleys-VolleyBall Manager
- Team: Development Team
- Epic: Kontinuierliche Code-Qualität

---

## 📊 Metriken & Monitoring

**Wie wird diese Routine überwacht?**

- Erfolgsrate: % Tagen mit durchgeführter Routine (Ziel: > 95%)
- Durchschnittliche Dauer: Sollte ≤ 20 Minuten sein
- Off-Task Bleiber: PR-Reviews, die an diesem Tag durchgeführt wurden (als Folge)

---

## 🔄 Wartung & Updates

**Wann wird diese Routine aktualisiert?**

- Updatefrequenz: Monatlich oder bei Tool-Änderungen
- Letzte Überprüfung: 23.03.2026
- Nächste geplante Überprüfung: 23.04.2026
- Review-Verantwortlicher: Tech Lead

---

## 📝 Changelog

| Version | Datum | Autor | Änderungen |
|---------|-------|-------|-----------|
| 1.0 | 23.03.2026 | System | Initiale Version erstellt (Beispiel) |
| - | - | - | - |

---

## 💡 Notizen & Besonderheiten

**Weitere wichtige Informationen:**

- **Best Practice:** Mache dies am Morgen VOR dem Schreiben von Code (ungestörter Focus)
- **Tipp:** Öffne mehrere tabs (einen pro PR) für schnelleres Review
- **Sicherheit:** Privater Inhalt in PRs? Nicht über Slack posten - nur in GitHub/GitLab
- **Performance:** Browser-Tab offen lassen reduziert Daily-Setup-Time

---

## 🎓 Lernziele

**Was lernt das System durch diese Routine?**

- **Lernziel 1:** Selbstdisziplin bei regelmäßiger Überprüfung von Aufgaben
- **Lernziel 2:** Priorisierungsfähigkeit unter Zeit-Druck
- **Lernziel 3:** Proaktive Kommunikation mit Team

---

**Tags:** `daily` `code-review` `mornings` `planning` `kurzfristig`

**Status:** 🟢 Aktiv & empfohlen

---

## 📌 Warum dieses Beispiel?

Dieses Beispiel zeigt:
✅ Wie ein Template **konkret** ausgefüllt wird
✅ Pradktische Schritte statt abstrakter Beschreibung
✅ Fehlerbehandlung im echten Leben
✅ Konkrete Erfolgskriterien & Metriken
✅ Verknüpfungen zu anderen Routinen

**Nutze dies als Template für deine neuen Routinen!**

---

**Version Beispiel:** 1.0
**Zweck:** Documental Reference
**Bitte nicht ändern** (Vorlage aus Templates)
