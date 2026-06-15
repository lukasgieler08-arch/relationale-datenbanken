# Informationsblatt Teil C: Daten einfügen

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil C: FoodTruckNetz

## Lernziele
- Du fügst Datensätze mit INSERT korrekt ein.
- Du beachtest Datentypen und Pflichtfelder.
- Du vermeidest Integritätsverletzungen.

## Grundmuster
```sql
INSERT INTO FOODTRUCK (TruckID, Name, Kategorie, Rating)
VALUES (101, 'Green Wheels', 'Vegan', 4.7);
```

## Mehrere Datensätze
```sql
INSERT INTO STANDORT (StandortID, Stadt)
VALUES (1, 'Kiel'), (2, 'Luebeck');
```

## Merksätze
- Spaltenliste immer explizit angeben.
- Reihenfolge von Spalten und Werten muss übereinstimmen.
- FK-Werte nur auf existierende PKs setzen.

## Typische Fehler
- Fehlende Pflichtspalten.
- Falsche Datumsformate.
- Fremdschlüssel auf nicht existente Datensätze.
