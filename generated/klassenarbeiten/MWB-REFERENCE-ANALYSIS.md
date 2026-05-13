# MWB Reference Analysis

Ausgewertet wurden native MySQL-Workbench-Archive aus dem Referenzordner.

## betreuung.mwb

Archive-Entries:
- @db/data.db
- document.mwb.xml
- lock

- Schema: mydb
  - Charset: utf8
  - Collation: utf8_general_ci
  - Tabellen: 0
- Schema: moebelhaus
  - Charset: (leer)
  - Collation: (leer)
  - Tabellen: 5
    - kinder: columns=4, fks=1, indices=2
    - kunden: columns=4, fks=0, indices=1
    - aktivitaeten: columns=2, fks=0, indices=1
    - betreuungen: columns=1, fks=0, indices=1
    - teilnahmen: columns=3, fks=3, indices=4

## freizeitpark.mwb

Archive-Entries:
- @db/data.db
- document.mwb.xml
- lock

- Schema: mydb
  - Charset: utf8
  - Collation: utf8_general_ci
  - Tabellen: 0
- Schema: eurowater
  - Charset: (leer)
  - Collation: (leer)
  - Tabellen: 5
    - attraktion: columns=6, fks=2, indices=3
    - besucher: columns=4, fks=0, indices=1
    - kategorie: columns=2, fks=0, indices=1
    - themenbereich: columns=2, fks=0, indices=1
    - Besuchsposition: columns=2, fks=2, indices=3

## parkplaetze.mwb

Archive-Entries:
- @db/data.db
- document.mwb.xml
- lock

- Schema: mydb
  - Charset: utf8
  - Collation: utf8_general_ci
  - Tabellen: 0
- Schema: freizeitpark_parkplatz
  - Charset: (leer)
  - Collation: (leer)
  - Tabellen: 4
    - parklatz: columns=3, fks=1, indices=2
    - fahrzeug: columns=3, fks=0, indices=1
    - parklatz_has_fahrzeug: columns=3, fks=2, indices=3
    - kategorie: columns=2, fks=0, indices=1
