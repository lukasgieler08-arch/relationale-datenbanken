# Informationsblatt Teil C: Daten löschen

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil C: FoodTruckNetz

## Lernziele
- Du löschst Datensätze mit DELETE kontrolliert.
- Du beachtest referentielle Integrität.
- Du unterscheidest fachlich sinnvolles Löschen von Archivieren.

## Grundmuster
```sql
DELETE FROM EINSATZ
WHERE EinsatzID = 5001;
```

## Sicherheitsroutine
1. Mit SELECT prüfen, welche Zeilen betroffen sind.
2. FK-Beziehungen prüfen.
3. Erst dann DELETE ausführen.

## Merksätze
- DELETE ohne WHERE entfernt alle Zeilen.
- Integritätsregeln können Löschungen blockieren.
- In realen Systemen ist „deaktivieren“ oft besser als endgültig löschen.

## Typische Fehler
- Falsche Reihenfolge bei abhängigen Datensätzen.
- Löschung ohne Vorprüfung.
- Fachlich wichtige Historie unabsichtlich entfernen.
