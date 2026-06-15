# Java-App live testen – Schritt-für-Schritt-Anleitung

**Ziel:** Die Volleyball-Team-Manager-Java-App kompilieren, alle Modell-Tests ausführen und (optional) die Swing-GUI starten.

---

## Übersicht: Zwei Test-Modi

| Modus | Voraussetzung | Einsatz |
|---|---|---|
| **Headless-Modell-Test** | Nur Java (kein Display) | Codespace, CI, Terminal |
| **GUI starten** | Java + lokales Display | Lokale Entwicklung, Windows/Mac |

---

## Modus 1 – Headless-Test im Codespace (empfohlen)

Dieser Modus testet die gesamte Geschäftslogik der App ohne grafische Oberfläche.
Er funktioniert direkt im Terminal des Codespace.

### Schritt 1 – Voraussetzungen prüfen

```bash
java -version
```

Erwartete Ausgabe (Beispiel):
```
openjdk version "17.0.x" ...
```

Falls Java fehlt:
```bash
sdk install java 17-ms
```

### Schritt 2 – Kompilieren und Modell-Tests ausführen (ein Befehl)

```bash
bash scripts/test-java.sh
```

Dieser Befehl:
1. Kompiliert alle Java-Dateien aus `src/volleyball/` nach `build/java/`
2. Führt `ModelSmokeTest` aus – 13 Tests der Kernlogik ohne Display

Erwartete Ausgabe:
```
[java] Kompilierung erfolgreich
[java] Starte Headless-Modell-Smoke-Tests...
  PASS  Startaufstellung hat 6 Spieler
  PASS  Erster Spieler ist Armin
  ...
[java-model-test] Ergebnis: 13 bestanden, 0 fehlgeschlagen
[java-model-test] Alle Tests erfolgreich
```

### Was wird getestet?

| Test | Was er prüft |
|---|---|
| Startaufstellung hat 6 Spieler | Korrekte Initialisierung |
| Erster Spieler ist Armin | Reihenfolge der Startdaten |
| Ersatzbank hat 6 Spieler | Korrekte Initialisierung |
| Erster Ersatzspieler ist Chris | Reihenfolge der Startdaten |
| Kader hat 12 Spieler gesamt | `getKader()` kombiniert beide Listen |
| Nach Tausch: Index 0 = Batu | `tausche()` Logik korrekt |
| Nach Tausch: Index 1 = Armin | `tausche()` Logik korrekt |
| Einfügen: 7 Spieler | `einfuegen()` fügt hinzu |
| Eingefügter Spieler an Position 0 | Einfügeposition korrekt |
| Kader-Typ Kaderspieler an [0] | OOP-Typen korrekt |
| Kader-Typ Ersatzspieler an [6] | OOP-Typen korrekt |
| Ungueltiger Tausch kein Fehler | Robustheit bei falschen Indizes |
| holeSpielerliste(99) = leer | Fallback bei ungültiger Auswahl |

### Schritt 3 – Einzeln kompilieren (optional, zur Fehlersuche)

```bash
mkdir -p build/java
javac -d build/java src/volleyball/*.java
```

### Schritt 4 – Einzelnen Modell-Test direkt aufrufen (optional)

```bash
java -cp build/java volleyball.ModelSmokeTest
```

---

## Modus 2 – GUI starten (lokal mit Display)

Die Swing-Oberfläche benötigt eine grafische Umgebung.
Im Codespace ist kein Display vorhanden – dafür bitte die lokale Java-Installation nutzen.

### Voraussetzung

- Java 17+ lokal installiert (z.B. via SDKMAN oder offizieller Installer)
- Repository lokal geklont **oder** VS Code verbindet sich via Remote-Container mit X11-Forwarding

### Schritt 5 – Kompilieren

```bash
mkdir -p build/java
javac -d build/java src/volleyball/*.java
```

### Schritt 6 – GUI starten

```bash
java -cp build/java volleyball.MainWindow
```

Das Hauptfenster des Volleyball-Team-Managers öffnet sich.

### App-Funktionen in der GUI

| Funktion | Beschreibung |
|---|---|
| Spieler anzeigen | Zeigt Startaufstellung, Ersatzbank oder Kader |
| Spieler tauschen | Tauscht zwei Spielerpositionen in einer Liste |
| Spieler einfügen | Fügt neuen Spieler an gewünschter Position ein |
| Spieler entfernen | Entfernt Spieler aus der Liste |

---

## Alle Dienste gemeinsam testen (Java + Docker-Services)

Um Java-Test zusammen mit MySQL, Python-API und PHP-Webapp zu prüfen:

```bash
bash scripts/test-services.sh
```

Dieser Befehl schließt `scripts/test-java.sh` automatisch mit ein.

Voraussetzung: Docker-Dienste laufen bereits (`bash scripts/start-services.sh`).

---

## Troubleshooting

### Fehler: `error: package volleyball does not exist`

Ursache: Falsche `javac`-Ausführungsebene.

Lösung: Befehl muss im Projektroot ausgeführt werden:
```bash
cd /workspaces/edu-code-projecttemplate
javac -d build/java src/volleyball/*.java
```

### Fehler: `java.awt.HeadlessException`

Ursache: GUI-Start wird ohne Display versucht (z.B. in Codespace).

Lösung: Im Codespace statt GUI den Headless-Modell-Test verwenden:
```bash
bash scripts/test-java.sh
```

### Fehler: `class not found: volleyball.MainWindow`

Ursache: Classpath fehlt oder Kompilierung nicht ausgeführt.

Lösung:
```bash
mkdir -p build/java
javac -d build/java src/volleyball/*.java
java -cp build/java volleyball.MainWindow
```

---

## Projektstruktur der Java-App

```
src/volleyball/
├── MainWindow.java                    ← View: Hauptfenster (Swing GUI)
├── SpielerWindow.java                 ← View: Spielerübersicht
├── SpielerEinfuegeWindow.java         ← View: Spieler einfügen
├── SpielerTauschWindow.java           ← View: Spieler tauschen
├── TeamManagerController.java         ← Controller: UI-Logik & Delegation
├── VolleyballspielerTeamManager.java  ← Model: Geschäftslogik & Datenhaltung
├── Spieler.java                       ← Abstrakte Basisklasse
├── Kaderspieler.java                  ← Konkrete Klasse: Startaufstellung
├── Ersatzspieler.java                 ← Konkrete Klasse: Ersatzbank
└── ModelSmokeTest.java                ← Headless-Test der Modell-Klasse
```

**Architekturmuster:** MVC (Model-View-Controller)

---

**Erstellt:** 26.03.2026
**Zugehörige Skripte:** `scripts/test-java.sh`, `scripts/test-services.sh`
