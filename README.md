# Stoffverlaufsplan Relationale Datenbanken (BG12)

Dieser Plan führt in 3 Wochen mit 9 Terminen (je 90 Minuten) strukturiert durch:

- Teil B: EERM, Kardinalitäten, Normalisierung, Anomalien
- Teil C: SQL-Abfragen über mehrere Tabellen
- Übungsphase: Anwendung und Selbstkontrolle

Ziel ist ein klarer roter Faden für selbstgesteuertes Arbeiten ohne Dokument-Hopping.

## Start

1. Öffne den tabellarischen Plan in dieser README.
2. Nutze für schnelle Navigation und Stichwortsuche die HTML-Version:
	- [Stoffverlaufsplan (HTML, mit Suche)](generated/anleitungen/stoffverlaufsplan_rdb_3wochen.html)
3. Arbeite Termin für Termin ab und nutze die Ergebniskontrollen (EK).

## Zentrale Materialien (einmalig verlinkt)

### Aufgaben und Lösungen

- A1: [Aufgabenstellung VERSION1 (Markdown)](generated/klassenarbeiten/KA02_BG12_2025_2026_VERSION1_aufg.md)
- A2: [Aufgabenstellung VERSION1 (HTML)](generated/klassenarbeiten/KA02_BG12_2025_2026_VERSION1_aufg.html)
- L1: [Lösung VERSION1 (Markdown)](generated/klassenarbeiten/KA02_BG12_2025_2026_VERSION1_lsg.md)
- L2: [Lösung VERSION1 (HTML)](generated/klassenarbeiten/KA02_BG12_2025_2026_VERSION1_lsg.html)

### Teil B Hilfsmittel

- B0: [Teil B Lernhilfe (Leitfaden)](generated/anleitungen/KA02_BG12_2025_2026_VERSION1_teil-b-hilfsmittel.md)
- B1: [Grundlagen Modellierung EERM](generated/informationen/teil-b/01_grundlagen_modellierung_eerm.md)
- B2: [Kardinalitäten (Eine-Sätze)](generated/informationen/teil-b/02_kardinalitaeten_eine_saetze_mengenmaessig.md)
- B3: [Normalisierung bis 3NF](generated/informationen/teil-b/03_normalisierung_bis_3nf.md)
- B4: [Redundanzen](generated/informationen/teil-b/04_redundanzen.md)
- B5: [Referentielle Integrität](generated/informationen/teil-b/05_referentielle_integritaet.md)

### Teil C Hilfsmittel

- C0: [Teil C Lernhilfe (Leitfaden)](generated/anleitungen/KA02_BG12_2025_2026_VERSION1_teil-c-hilfsmittel.md)
- C1: [SQL über mehrere Tabellen](generated/informationen/teil-c/01_sql_abfragen_ueber_mehrere_tabellen.md)
- C2: [Selektion in SQL](generated/informationen/teil-c/03_selektion_in_sql.md)
- C3: [Gruppierung in SQL](generated/informationen/teil-c/06_gruppierung_in_sql.md)

### Übungen und Daten

- U0: [Übungsübersicht](generated/uebungen/README.md)
- U1: [UE01 FoodTruckNetz](generated/uebungen/UE01_foodtrucknetz_sql_abfragen.html)
- U2: [UE02 Stadtfahrradverleih](generated/uebungen/UE02_stadtfahrradverleih_sql_abfragen.html)
- D1: [foodtrucknetz_struktur_2025.sql](generated/klassenarbeiten/foodtrucknetz_struktur_2025.sql)
- D2: [foodtrucknetz_uebung_daten.sql](generated/uebungen/daten/foodtrucknetz_uebung_daten.sql)
- D3: [stadtfahrradverleih_struktur_2025.sql](generated/klassenarbeiten/stadtfahrradverleih_struktur_2025.sql)
- D4: [stadtfahrradverleih_uebung_daten.sql](generated/uebungen/daten/stadtfahrradverleih_uebung_daten.sql)

### Nachschlagewerk

- N1: [Stichwortverzeichnis (Markdown)](generated/informationen/begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.md)
- N2: [Stichwortverzeichnis (HTML)](generated/informationen/begrifflichkeiten/stichwortverzeichnis_relationale_datenbanken.html)
- W1: [Workbench-Workflow](generated/klassenarbeiten/WORKBENCH-MWB-WORKFLOW.md)

## Ergebniskontrolle (EK)

- EK1: Fachbegriffe korrekt in Entitätstypen, Beziehungen und Attribute überführt.
- EK2: Kardinalitäten mit Eine-Sätzen beidseitig abgesichert.
- EK3: Modell ist 3NF-fähig, Redundanzen und Anomalien sind begründet.
- EK4: SQL-Abfragen liefern das erwartete Ergebnis bei JOIN, GROUP BY, HAVING und LEFT JOIN.
- EK5: Klausurnahe Gesamtaufgabe unter Zeitvorgabe bearbeitet und mit L1/L2 geprüft.

## Stoffverlaufsplan (9 Termine)

| Termin | Aufgabe/Meilenstein je Einheit (90 Min) | Informationen/Hilfsmittel | Ergebniskontrolle |
|---|---|---|---|
| 1 | Einstieg in den Sachverhalt, Entitätstypen und Attribute aus A1 extrahieren. | A1, B0, B1, N1 | EK1 |
| 2 | SQL-Kontext lesen: Tabellenrollen, Schlüssel und Join-Ketten verstehen. | A1, C0, C1, D3, D4 | EK4 |
| 3 | Übungen UE01 A1-A5 lösen (JOIN, WHERE, GROUP BY) und Ergebnisse vergleichen. | U0, U1, C1, C2, C3, N2 | EK4 |
| 4 | Kardinalitäten präzisieren und EERM fachlich absichern; 1:N vs. N:M begründen. | A1, B0, B2, B5, W1 | EK2 |
| 5 | Normalisierung bis 3NF und Anomalien systematisch auf das Modell anwenden. | A1, B3, B4, L1 | EK3 |
| 6 | Übungen UE01 A6-A10 und UE02 A1-A3; Datums- und Aggregatlogik festigen. | U1, U2, C2, C3, D1, D2 | EK4 |
| 7 | Teil-B-Konsolidierung: vollständiges EERM prüfen und mit L1/L2 abgleichen. | A1, L1, L2, B1, B2, B3, B4 | EK1, EK2, EK3 |
| 8 | Teil-C-Konsolidierung: klausurnahe Aufgaben 4.1-4.4 lösen und begründen. | A1, L1, C0, C1, C2, C3, U2 | EK4 |
| 9 | Gesamtdurchlauf unter Zeitvorgabe: Teil B + Teil C + Übungsreflexion dokumentieren. | A1, L1, L2, B0, C0, N2 | EK5 |

## Didaktischer roter Faden

- Termin 1 bis 3: Verstehen und erste Anwendung.
- Termin 4 bis 6: Struktur absichern und Abfragekompetenz ausbauen.
- Termin 7 bis 9: Klausurtransfer, Selbstkontrolle und Konsolidierung.

Damit wird zuerst die Modellierungskompetenz aufgebaut, dann die SQL-Kompetenz gefestigt und abschließend beides integriert.
