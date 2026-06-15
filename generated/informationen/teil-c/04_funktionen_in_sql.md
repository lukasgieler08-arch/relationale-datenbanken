# Informationsblatt Teil C: Funktionen in SQL

Zielgruppe: Sekundarstufe II (Abschlussjahr)  
Kontext Teil C: FoodTruckNetz

## Lernziele
- Du setzt SQL-Funktionen zweckgerecht ein.
- Du unterscheidest Zeilenfunktionen und Aggregatfunktionen.
- Du formatierst Ergebnisse verständlich.

## Beispiele für Zeilenfunktionen
```sql
SELECT UPPER(Name) AS NameGross
FROM FOODTRUCK;
```

```sql
SELECT ROUND(Rating, 1) AS Bewertet
FROM FOODTRUCK;
```

## Beispiele für Aggregatfunktionen
```sql
SELECT COUNT(*) AS AnzahlTrucks
FROM FOODTRUCK;
```

```sql
SELECT AVG(Rating) AS Durchschnitt
FROM FOODTRUCK;
```

## Merksätze
- Aggregatfunktionen verdichten mehrere Zeilen.
- Aliasnamen machen Ergebnisse lesbar.
- Funktionseinsatz muss fachlich begründet sein.

## Typische Fehler
- Aggregat und Nicht-Aggregat ohne GROUP BY mischen.
- Rundung zu früh durchführen.
- Falsche Datentypannahmen.
