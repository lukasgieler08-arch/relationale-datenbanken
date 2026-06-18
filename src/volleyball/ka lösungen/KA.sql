Aufgabe 4.2 (SQL - Personen mit ≥2 Ausleihen)
Das Prinzip: Wenn wir Daten zählen wollen, müssen wir die Tabelle in "Gruppen" unterteilen (wie Sortierstapel auf einem Schreibtisch).

SQL
-- SCHRITT 1: Was wollen wir sehen?
SELECT k.nachname, k.vorname, 
       COUNT(a.ausleihe_id) AS anzahl_ausleihen  -- COUNT ist der Zähler, der die Zettel im Stapel zählt

-- SCHRITT 2: Woher kommen die Daten?
FROM kunden k
JOIN ausleihen a ON k.kunde_id = a.kunde_id  -- Verbinde Kunden mit ihren Fahrten

-- SCHRITT 3: Vor-Filtern (Wer fliegt sofort raus?)
WHERE a.status = 'abgeschlossen'  -- Bevor wir überhaupt zählen, fliegen unfertige Fahrten raus

-- SCHRITT 4: Die Stapelbildung (Gruppierung)
GROUP BY k.kunde_id, k.nachname, k.vorname
  -- WICHTIG: SQL baut jetzt für jeden Kunden einen eigenen Zettelstapel auf.
  -- Alles, was oben im SELECT steht und kein Zähler ist, MUSS hier unten reingeschrieben werden!

-- SCHRITT 5: Nach-Filtern (Welcher Stapel interessiert uns?)
HAVING COUNT(a.ausleihe_id) >= 2
  -- MERKSATZ: "WHERE" filtert einzelne Zeilen ganz am Anfang.
  -- "HAVING" filtert die fertigen Stapel NACH dem Zählen. Wir behalten nur Stapel mit 2 oder mehr Zetteln.

-- SCHRITT 6: Sortierung
ORDER BY anzahl_ausleihen DESC;  -- Die Person mit den meisten Ausleihen (DESC = absteigend) steht oben.
Aufgabe 4.3 (SQL - Pro Station: Letzter Start + Kundenanzahl)
Das Prinzip: Hier nutzen wir mathematische Funktionen (MAX für das neueste Datum) und DISTINCT (um Duplikate beim Zählen zu ignorieren).

SQL
-- SCHRITT 1: Die Auswertung festlegen
SELECT s.stationsname, 
       MAX(a.startzeit) AS letzter_start,  -- MAX sucht aus allen Daten das allerneueste Datum heraus
       COUNT(DISTINCT a.kunde_id) AS unterschiedliche_kunden
       -- DISTINCT ist ein Doppelungs-Filter. Wenn Kunde Nr. 5 fünfmal an dieser Station war, 
       -- sorgt DISTINCT dafür, dass er trotzdem nur als EIN (1) Kunde gezählt wird.

-- SCHRITT 2: Woher kommen die Daten?
FROM stationen s
JOIN ausleihen a ON s.station_id = a.start_station_id  -- Uns interessieren nur die STARTS an dieser Station

-- SCHRITT 3: Stapel pro Bahnhof bilden
GROUP BY s.station_id, s.stationsname;  -- SQL bildet für jeden Bahnhof einen eigenen Auswertungsstapel
Aufgabe 4.4 (SQL - Fahrräder ohne Wartung)
Das Prinzip: Normalerweise löscht ein JOIN alle Daten, die keinen Partner in der anderen Tabelle haben. Wenn ein Fahrrad noch nie in der Werkstatt war, würde es unsichtbar werden. Hier hilft der LEFT JOIN.

SQL
-- SCHRITT 1: Was wollen wir finden?
SELECT f.fahrrad_id, f.typname, f.seriennummer

-- SCHRITT 2: Die "gütige" Verknüpfung (LEFT JOIN)
FROM fahrraeder f
LEFT JOIN wartungen w ON f.fahrrad_id = w.fahrrad_id
  -- "LEFT" bedeutet: Die Tabelle LINKS vom Wort JOIN (fahrraeder) ist der Chef. 
  -- Jedes Fahrrad bleibt fest in der Liste stehen! Wenn es noch nie in der Wartung war, 
  -- bleibt die rechte Seite der Tabelle (w.wartung_id) einfach komplett LEER (NULL).

-- SCHRITT 3: Nach den leeren Feldern suchen
WHERE w.wartung_id IS NULL;
  -- "IS NULL" bedeutet "ist leer". Damit filtern wir genau die Fahrräder heraus, 
  -- die beim LEFT JOIN auf der Wartungsseite keinen Partner gefunden haben.
Aufgabe D (Struktogramm / Ablauf)
Das Prinzip: Ein Struktogramm liest sich immer strikt von oben nach unten (eine sogenannte Sequenz).

ANFANG
  EINGABE: tage             <-- Computer fragt: Wie viele Tage?
  EINGABE: tagespreis       <-- Computer fragt: Wie teuer pro Tag?
  gesamtkosten := tage * tagespreis  <-- Computer rechnet im Hintergrund
  AUSGABE: gesamtkosten     <-- Ergebnis wird auf dem Bildschirm angezeigt
ENDE