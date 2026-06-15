# Relationale Datenbanken: Live-Test und Webserver-Setup

## Ziel

Diese Anleitung beschreibt die technische Test- und Betriebsumgebung für die Webapp rund um relationale Datenbanken. Sie richtet sich an Schulen, Informatiklehrkräfte und Administratoren, die das Repository lokal oder auf einem Webserver betreiben möchten.

Die Anwendung ist auf folgende Lernszenarien ausgelegt:

- EERM modellieren
- 3. Normalform begründen
- SQL ausführen und prüfen
- Webapp, API und Datenbank gemeinsam testen

## Architektur im Betrieb

Die Laufzeitumgebung besteht aus vier Bausteinen:

1. Apache mit PHP für die Webapp
2. Python-API für ergänzende Daten- und Analyseendpunkte
3. MySQL für Testdaten, SQL-Ausführung und relationale Modelle
4. Docker Compose für einen reproduzierbaren Live-Test

## Mindestvoraussetzungen auf einem Zielsystem

## Betrieb per Docker

Empfohlen für Schulen und lokale Entwicklung:

- Docker Engine mit Compose-Unterstützung
- mindestens 4 GB RAM für den Gesamtstack
- freier Zugriff auf die Ports 8080 und 8000 sowie optional 3306

## Betrieb ohne Docker

Wenn die Dienste getrennt auf einem Server installiert werden, werden mindestens benötigt:

- Apache 2.4 oder kompatibler Webserver
- PHP 8.3 mit `mysqli`, `pdo` und `pdo_mysql`
- MySQL 8.x
- Python 3.12 für die API
- optional phpMyAdmin für Administrationszugriffe
- optional MySQL Workbench für Modellierung und EERM-Pflege

## Empfohlene lokale Werkzeuge für Lehrkräfte

- Visual Studio Code oder ein vergleichbarer Editor
- MySQL Workbench für EERM und Datenbankmodellierung
- optional phpMyAdmin für schnelle Datenprüfungen im Browser
- PDF-fähiger Viewer für Lehrpläne aus `uploads/lehrplaene/`

## Schnellstart mit Docker

## Schritt 1: Repository vorbereiten

Im Projektverzeichnis arbeiten:

```bash
cd /workspaces/edu-code-course-rdb
```

## Schritt 2: Konfiguration erzeugen

Wenn noch keine `.env` vorhanden ist, wird sie vom Startskript automatisch aus `.env.example` erzeugt.

Wichtig:

- gültige Werte für `MYSQL_ROOT_PASSWORD` und `MYSQL_PASSWORD` setzen
- keine Platzhalterwerte beibehalten

## Schritt 3: Dienste starten

```bash
bash scripts/start-services.sh
```

Das Skript:

- lädt die Umgebungsvariablen
- startet MySQL, Python-API und PHP-Webapp per Docker Compose
- baut geänderte Images neu
- gibt die erreichbaren Adressen aus

## Schritt 4: Live-Test ausführen

```bash
bash scripts/test-services.sh
```

Der Test prüft:

- Python-Health-Endpunkt
- Python-JSON-Endpunkt
- Lehrplan-API mit generierten Curricula-Artefakten
- PHP-Webseite
- MySQL-Zugriff im Container
- Java-Smoke-Test

## Schritt 5: Webapp im Browser öffnen

Standardmäßig:

- Webapp: http://localhost:8080
- Python-API: http://localhost:8000/health

## Server-Voraussetzungen im Detail

## Apache + PHP

Erforderlich:

- aktiviertes PHP 8.3 oder kompatibel
- PHP-Erweiterungen `mysqli`, `pdo`, `pdo_mysql`
- Dokumentenwurzel auf `webapp/public/`
- Schreibzugriff nur dort, wo wirklich nötig
- Fehlerausgabe nicht produktiv an Clients ausliefern

## MySQL

Erforderlich:

- MySQL 8.x
- eigener Datenbankbenutzer mit minimal nötigen Rechten
- UTF-8 kompatible Konfiguration
- Initialisierung der Beispieldaten aus `docker/mysql/init/`

## Python-API

Erforderlich:

- Python 3.12
- Netzwerkzugriff auf MySQL
- saubere Konfiguration der Umgebungsvariablen
- getrennte Bereitstellung hinter Reverse Proxy oder internem Netz empfohlen

## Schritt-für-Schritt: Apache lokal oder auf Linux-Server

## 1. Apache und PHP installieren

Beispiel Ubuntu:

```bash
sudo apt update
sudo apt install apache2 php php-mysql libapache2-mod-php
```

## 2. Projekt bereitstellen

Das Repository auf den Server kopieren und den Webroot auf `webapp/public/` zeigen lassen.

## 3. Apache-VHost konfigurieren

Typische Punkte:

- `DocumentRoot` auf `webapp/public`
- `AllowOverride None` oder bewusst gesteuerte Regeln
- Directory-Zugriff nur für den nötigen Pfad
- keine Verzeichnisauflistung für sensible Bereiche

## 4. Umgebungsvariablen bereitstellen

Mindestens:

- `MYSQL_HOST`
- `MYSQL_PORT`
- `MYSQL_DATABASE`
- `MYSQL_USER`
- `MYSQL_PASSWORD`
- `PYTHON_API_URL`

## 5. Webapp testen

Prüfen:

- lädt die Startseite?
- funktioniert PHP-MySQL?
- funktioniert JavaScript-Python-API?
- sind die Lernpfade und Übungsboxen sichtbar?

## Schritt-für-Schritt: MySQL einrichten

## 1. MySQL installieren

Beispiel Ubuntu:

```bash
sudo apt install mysql-server
```

## 2. Datenbank und Benutzer anlegen

- eigene Datenbank für die Anwendung anlegen
- eigenen Benutzer mit starkem Passwort anlegen
- nur benötigte Rechte vergeben

## 3. Initialdaten importieren

Für eine lokale Testumgebung können die SQL-Dateien aus `docker/mysql/init/` oder aus den generierten Artefakten genutzt werden.

## Schritt-für-Schritt: phpMyAdmin optional ergänzen

phpMyAdmin ist optional, aber für Unterricht und Diagnose praktisch.

Empfehlung:

- nicht öffentlich offen betreiben
- Zugriff absichern
- nur für Lehrkräfte oder lokale Netze bereitstellen

## Schritt-für-Schritt: MySQL Workbench einsetzen

Workbench wird für EERM und Datenmodellierung empfohlen.

Vorgehen:

1. MySQL Workbench installieren
2. Verbindung zum MySQL-Server einrichten
3. vorhandene SQL-Strukturen importieren
4. EERM pflegen oder neue Modelle erstellen
5. bei Bedarf Grafiken exportieren

Für den SQL-Teil von Prüfungen und Lernmaterialien bleibt die 3NF-Modellierung in einem separaten Kontext verbindlich.

## Didaktischer Live-Test für den Unterricht

Eine vollständige Lernumgebung sollte mindestens diese Prüfpfade abdecken:

- EERM-Sachverhalt vorhanden
- 3NF-Struktur ableitbar
- SQL-Testdaten verfügbar
- Webapp-Lernpfad sichtbar
- Selbstkontrolle im Übungsbereich nutzbar
- Musterlösungen und Hilfen dokumentiert

## Wartung und Qualitätssicherung

Vor Abschluss jeder Änderung ausführen:

```bash
bash scripts/validate-security.sh
bash scripts/validate-architecture.sh
bash scripts/validate-docs.sh
```

Zusätzlich bei Betriebsänderungen sinnvoll:

```bash
bash scripts/start-services.sh
bash scripts/test-services.sh
```

## Verknüpfte Dokumente

- [README.md](../README.md)
- [INDEX.md](../INDEX.md)
- [ARCHITEKTUR.md](../ARCHITEKTUR.md)
- [PFLICHTENHEFT.md](../PFLICHTENHEFT.md)
- [lehrplanbasierte-inhaltserweiterung.md](../prozesse/lehrplanbasierte-inhaltserweiterung.md)
