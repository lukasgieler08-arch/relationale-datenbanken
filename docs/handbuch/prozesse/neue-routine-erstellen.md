# PROZESS: Neue Routine erstellen

**Dokumentversion:** 1.0
**Ziel:** Standardisierter Prozess für das Erstellen neuer Lernroutinen
**Zielgruppe:** Alle Entwickler, Dokumentatoren, Prozess-Manager

---

## 🎯 Überblick

Dieser Prozess sichert:
- ✅ **Konsistenz** - Alle Routinen folgen dem gleichen Standard
- ✅ **Qualität** - Review & Validierung vor Veröffentlichung
- ✅ **Keine Redundanzen** - Bestehende Routinen werden überprüft
- ✅ **Nachvollziehbarkeit** - Alle Entscheidungen werden dokumentiert

**Geschätzter Gesamtaufwand:** 1-2 Stunden
**Rollen:** Ersteller, Reviewer, Approver

---

## 📋 Schritt-für-Schritt Anleitung

### Phase 1: PLANUNG & VORBEREITUNG (15-30 Min)

#### Schritt 1.1: Anforderung definieren
**Frage:** Was möchte ich dokumentieren und warum?

1. **Anforderung schriftlich festhalten:**
   ```
   Neue Routine für: [Handlung/Prozess]
   Grund/Motivation: [Warum ist das wichtig?]
   Zielgruppe: [Wer soll das nutzen?]
   Zeitraum: [Wie oft? Täglich/Wöchentlich/Monatlich?]
   ```

2. **Kategorie wählen:**
   - 📅 **Kurzfristig:** täglich oder wöchentlich
   - 📆 **Mittelfristig:** monatlich oder quartalsweise
   - 📊 **Langfristig:** jährlich oder strategisch

#### Schritt 1.2: Bestehende Routinen überprüfen
**WICHTIG:** Nicht einfach eine neue Routine erstellen, wenn eine ähnliche bereits existiert!

1. **Im Repository suchen:**
   ```bash
   # Terminal-Befehl
   grep -r "Keyword" docs/handbuch/routinen/
   find docs/handbuch/routinen -name "*.md" | xargs grep -l "keywords"
   ```

2. **Fragen stellen:**
   - Gibt es bereits eine ähnliche Routine?
   - Könnte diese Routine erweitert statt neu erstellt werden?
   - Sind Teile davon in anderen Routinen dokumentiert?

3. **Verdacht auf Redundanz?** → Siehe [PROZESS: Redundanz-Management](redundanz-management.md)

#### Schritt 1.3: Bestehende Abhängigkeiten identifizieren
**Frage:** Welche anderen Routinen sind mit dieser verknüpft?

1. **Abhängigkeits-Analyse:**
   - Welche Routinen **müssen** vor dieser laufen?
   - Welche Routinen könnten **danach** laufen?
   - Welche teilen sich Ressourcen/Ausgaben?

2. **Abhängigkeiten notieren:** (Werden später im Template eingetragen)

---

### Phase 2: DOKUMENTATION (30-45 Min)

#### Schritt 2.1: Datei erstellen

1. **Branch erstellen:**
   ```bash
   git checkout -b routine/ROUTINE-XXX-beschreibender-name
   ```

2. **Datei anlegen mit eindeutiger ID:**
   ```bash
   # Beispiel für kurzfristige Routine
   touch docs/handbuch/routinen/kurzfristig/KF-ROUTINE-001-Name.md

   # Beispiel für mittelfristige Routine
   touch docs/handbuch/routinen/mittelfristig/MF-ROUTINE-001-Name.md
   ```

3. **Naming-Konventionen:**
   - Format: `[KATEGORIE-ROUTINE-XXX]-aussagekräftiger-name.md`
   - Kategorien: `KF` (kurzfristig), `MF` (mittelfristig), `LF` (langfristig)
   - ID: Fortlaufend in jeder Kategorie (001, 002, 003, ...)
   - Name: Lowercase, Hyphens, max. 50 Zeichen

#### Schritt 2.2: Template ausfüllen

1. **Template kopieren:**
   ```bash
   cp docs/handbuch/templates/ROUTINE-TEMPLATE.md \
      docs/handbuch/routinen/[kategorie]/[NEUE-ROUTINE].md
   ```

2. **Alle Abschnitte ausfüllen** (Siehe ROUTINE-TEMPLATE.md):
   - ✅ Metadata (ID, Name, Kategorie, etc.)
   - ✅ Ziel & Überblick
   - ✅ Vorbedingungen & Abhängigkeiten
   - ✅ Schritte (detailliert)
   - ✅ Erfolgskriterien
   - ✅ Fehlerbehandlung
   - ✅ Ausgaben/Ergebnisse
   - ✅ Ressourcen & Referenzen
   - ✅ Verknüpfungen
   - ✅ Changelog

3. **Inhalt prüfen:**
   - [ ] Ist alles verständlich?
   - [ ] Sind Schritte nachvollziehbar?
   - [ ] Sind Code-Beispiele korrekt?
   - [ ] Sind Links funktionsfähig?

#### Schritt 2.3: Best Practices beachten

**Was macht eine gute Routine-Dokumentation aus?**

| Merkmal | Bedeutung | Beispiel |
|---------|-----------|---------|
| **Klar & Prägnant** | Gut zu verstehen | "Täglich 30 Min Test schreiben" |
| **Messbar** | Erfolg ist nachprüfbar | "Erfolgreich: 100% Tests bestanden" |
| **Ohne Redundanz** | Keine Wiederholungen | Abhängigkeiten nutzen |
| **Wartbar** | Leicht zu aktualisieren | Klare Struktur, Changelog |
| **Verlinkt** | Kontext ist hergestellt | Verwandte Routinen verlinken |

---

### Phase 3: VALIDIERUNG (15-30 Min)

#### Schritt 3.1: Selbst-Check durchführen

**Validierungs-Checkliste:**

```markdown
## Vor dem Submit

- [ ] Alle Metadata ausgefüllt (ID, Status, Version, etc.)
- [ ] Mindestens 3-5 konkrete Schritte dokumentiert
- [ ] Erfolgs-Kriterien sind messbar/überprüfbar
- [ ] Abhängigkeiten identifiziert & verlinkt
- [ ] Keine Redundanzen mit anderen Routinen
- [ ] Changelog aktualisiert (v1.0 eingetragen)
- [ ] Markdown-Formatierung OK
- [ ] Alle Links validiert
- [ ] Keine Typos oder Grammatik-Fehler
- [ ] Zeitaufwand realistisch geschätzt
```

#### Schritt 3.2: Lokal testen

1. **Formatierung prüfen:**
   ```bash
   # In VS Code öffnen und Preview ansehen
   code docs/handbuch/routinen/[kategorie]/[ROUTINE].md

   # Oder: Markdown in Terminal sichtbar machen
   cat docs/handbuch/routinen/[kategorie]/[ROUTINE].md | head -50
   ```

2. **Links validieren:**
   - Alle `[Text](link)` sind korrekt?
   - Interne Links zeigen auf existierende Dateien?
   - Externe Links sind erreichbar?

3. **Redundanz-Check (manuell):**
   - Ähnliche Routine in anderem Ordner?
   - Ähnliche Ziele in anderer Routine?
   - Könnte zusammengeführt werden?

---

### Phase 4: REVIEW & GENEHMIGUNG (30-45 Min)

#### Schritt 4.1: Pull Request erstellen

1. **Commit erstellen:**
   ```bash
   git add docs/handbuch/routinen/[kategorie]/[ROUTINE].md
   git commit -m "NEUE ROUTINE: [ROUTINE-ID] - [Kurzbeschreibung]"
   ```

2. **Branch pushen:**
   ```bash
   git push origin routine/ROUTINE-XXX-beschreibender-name
   ```

3. **Pull Request öffnen (via GitHub):**
   - Title: `NEUE ROUTINE: [ROUTINE-ID] - [Name]`
   - Description:
     ```markdown
     ## Neue Routine: [Name]

     ### Was wurde hinzugefügt?
     [Kurzbeschreibung]

     ### Kategorie & Zeitraum
     - Kategorie: kurzfristig / mittelfristig / langfristig
     - Häufigkeit: täglich / wöchentlich / monatlich / jährlich

     ### Warum ist das wichtig?
     [Begründung]

     ### Abhängigkeiten
     - [ ] [ROUTINE-XXX: Name]
     - [ ] [ROUTINE-YYY: Name]

     ### Checkliste
     - [x] Template vollständig ausgefüllt
     - [x] Keine Redundanzen identifiziert
     - [x] Links validiert
     - [x] Markdown-Format OK
     ```

4. **Reviewer taggen:**
   - Mindestens 1 Reviewer zuweisen
   - Mit Team-Lead/Prozess-Owner abstimmen

#### Schritt 4.2: Review durchführen lassen

**Der Reviewer prüft:**
- ✅ Erfüllt die Routine einen echten Bedarf?
- ✅ Ist es redundanzfrei?
- ✅ Sind Schritte nachvollziehbar?
- ✅ Sind Erfolgskriterien messbar?
- ✅ Fehlt etwas wichtiges?

#### Schritt 4.3: Feedback einarbeiten

1. **Review-Kommentare ansehen**
2. **Lokale Änderungen machen:**
   ```bash
   # Branch noch lokal?
   git checkout routine/ROUTINE-XXX-beschreibender-name

   # Änderungen machen...
   # ...

   # Commit:
   git add .
   git commit -m "Review-Feedback: [Was geändert wurde]"
   git push origin routine/ROUTINE-XXX-beschreibender-name
   ```

3. **PR-Kommentar hinzufügen:**
   "Feedback eingearbeitet. Bereit zum Merge."

---

### Phase 5: VERÖFFENTLICHUNG (10-15 Min)

#### Schritt 5.1: Merge in Develop-Branch

1. **Nach Approval mergen:**
   - "Squash and merge" für saubere History
   - Oder "Create merge commit" für volle Nachvollziehbarkeit

2. **Branch löschen:**
   ```bash
   git push origin --delete routine/ROUTINE-XXX-beschreibender-name
   ```

#### Schritt 5.2: Update in Kategorie-Index

1. **Index in der Kategorie-Datei aktualisieren:**
   ```bash
   # Beispiel: kurzfristig/README.md oder Index-Datei
   echo "- [KF-ROUTINE-XXX: Name](KF-ROUTINE-XXX-Name.md)" >> docs/handbuch/routinen/kurzfristig/INDEX.md
   ```

#### Schritt 5.3: Changelog aktualisieren

1. **MARSCHPLAN.md aktualisieren:**
   ```markdown
   ## Neue Routinen (aktuell)
   - [x] [ROUTINE-ID: Name](link) - Erstellt am [Datum]
   ```

2. **Release Notes vorbereiten** (für größere Releases)

---

## 🔍 Qualitätssicherung

### Automatische Validierung (fallweise verfügbar)

```bash
# Markdown Syntax prüfen
mdl docs/handbuch/routinen/*/

# Links validieren
linkchecker docs/handbuch/routinen/*/

# Redundanzen suchen
grep -r "Schlagwort" docs/handbuch/routinen/
```

### Manuelle Checkliste

- [ ] Eindeutige ID (nicht doppelt)
- [ ] Eindeutiger Name
- [ ] Keine Redundanzen
- [ ] Alle Links gültig
- [ ] Keine Placeholder ("TODO", "FIXME")
- [ ] Änderungshistorie dokumentiert
- [ ] Zeitaufwand realistisch
- [ ] Zielgruppe klar
- [ ] Abhängigkeiten dokumentiert

---

## ⏱️ Aufwandschätzung

| Phase | Aufwand | Notizen |
|-------|---------|---------|
| Planung | 15-30 Min | Diskussion, Umfang-Definition |
| Dokumentation | 30-45 Min | Template ausfüllen, Review |
| Validierung | 15-30 Min | Selbst-Check, Tests |
| Review | 30-45 Min | Externer Review, Feedback |
| Veröffentlichung | 10-15 Min | Merge, Update Index |
| **TOTAL** | **~1,5-2 Stunden** | Je nach Komplexität |

---

## 🆘 Häufige Probleme & Lösungen

| Problem | Symptom | Lösung |
|---------|---------|--------|
| Nichts zum Dokumentieren | Ideenlosigkeit | Brainstorming-Session, Feedback sammeln |
| Redundanz gefunden | Routine ähnelt anderer | Redundanz-Management starten |
| Review blockiert | Kommentare unklar | Direktes Gespräch mit Reviewer |
| ID-Kollision | Andere hat gleiche ID | Nächste verfügbare ID nutzen |

---

## 📚 Weiterführende Dokumente

- 📖 [ROUTINE-TEMPLATE.md](../templates/ROUTINE-TEMPLATE.md) - Standard-Template
- 📖 [redundanz-management.md](redundanz-management.md) - Bei ähnlichen Routinen
- 📖 [review-prozess.md](review-prozess.md) - Detaillierte Review-Anforderungen
- 📖 [ARCHITEKTUR.md](../ARCHITEKTUR.md) - Systemarchitektur

---

**Version:** 1.0
**Letzte Aktualisierung:** 23.03.2026
