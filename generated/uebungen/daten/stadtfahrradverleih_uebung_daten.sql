-- ============================================================
--  stadtfahrradverleih_uebung_daten.sql
--  Eigenständiger Datendump für die Übungsreihe (erweitert)
--  Kontext: Stadtfahrradverleih (6 Entitätstypen, Schuljahr 2025)
--  WICHTIG: Struktur-Dump zuerst einlesen!
--  > mysql -u root -p < ../klassenarbeiten/stadtfahrradverleih_struktur_2025.sql
--  Dann diese Datei:
--  > mysql -u root -p < daten/stadtfahrradverleih_uebung_daten.sql
-- ============================================================

USE stadtfahrradverleihdb_2025;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE zahlungen;
TRUNCATE TABLE wartungen;
TRUNCATE TABLE ausleihen;
TRUNCATE TABLE fahrraeder;
TRUNCATE TABLE stationen;
TRUNCATE TABLE kunden;
SET FOREIGN_KEY_CHECKS = 1;

-- ────────────────────────────────────────────────
--  KUNDEN (6 Datensätze)
-- ────────────────────────────────────────────────
INSERT INTO kunden VALUES
(1, 'Lea',   'Keller',   'Mitte', '2024-01-10', 1),
(2, 'Noah',  'Weber',    'Nord',  '2024-02-02', 1),
(3, 'Mia',   'Schmidt',  'West',  '2024-03-18', 1),
(4, 'Elias', 'Nguyen',   'Sued',  '2024-04-04', 1),
(5, 'Lina',  'Bauer',    'Mitte', '2024-04-29', 1),
(6, 'Paul',  'Hoffmann', 'Nord',  '2024-05-14', 1);

-- ────────────────────────────────────────────────
--  STATIONEN
-- ────────────────────────────────────────────────
INSERT INTO stationen VALUES
(10, 'Hauptbahnhof', 'Mitte', 30, 1),
(11, 'Campus Nord',  'Nord',  22, 1),
(12, 'Stadtpark',    'West',  18, 1),
(13, 'Rathaus',      'Sued',  16, 1);

-- ────────────────────────────────────────────────
--  FAHRRAEDER
-- ────────────────────────────────────────────────
INSERT INTO fahrraeder VALUES
(100, 10, 'City',     3.50, 'SN-C-100', 'verfuegbar'),
(101, 10, 'E-Bike',   5.80, 'SN-E-101', 'vermietet'),
(102, 11, 'Trekking', 4.20, 'SN-T-102', 'verfuegbar'),
(103, 11, 'City',     3.50, 'SN-C-103', 'wartung'),
(104, 12, 'E-Bike',   5.80, 'SN-E-104', 'verfuegbar'),
(105, 12, 'City',     3.50, 'SN-C-105', 'verfuegbar'),
(106, 13, 'Trekking', 4.20, 'SN-T-106', 'verfuegbar'),
(107, 13, 'City',     3.50, 'SN-C-107', 'vermietet');

-- ────────────────────────────────────────────────
--  AUSLEIHEN (21 Datensätze – März, April, Mai 2025)
-- ────────────────────────────────────────────────
INSERT INTO ausleihen VALUES
-- März 2025
(2000, 1, 100, 10, 12, '2025-03-10 08:10:00', '2025-03-10 09:05:00', 'abgeschlossen'),
(2001, 2, 101, 10, 11, '2025-03-10 09:20:00', '2025-03-10 10:00:00', 'abgeschlossen'),
(2002, 3, 102, 11, 10, '2025-03-10 10:10:00', NULL,                   'laufend'),
(2003, 1, 104, 12, 13, '2025-03-11 08:00:00', '2025-03-11 09:10:00', 'abgeschlossen'),
(2004, 4, 105, 12, 10, '2025-03-11 11:20:00', '2025-03-11 12:15:00', 'abgeschlossen'),
(2005, 5, 106, 13, 12, '2025-03-12 07:40:00', '2025-03-12 08:10:00', 'abgeschlossen'),
(2006, 2, 107, 13, 10, '2025-03-12 09:00:00', NULL,                   'laufend'),
(2007, 6, 100, 10, 11, '2025-03-12 12:30:00', '2025-03-12 13:05:00', 'abgeschlossen'),
-- April 2025
(2008, 3, 102, 11, 10, '2025-04-01 07:30:00', '2025-04-01 08:20:00', 'abgeschlossen'),
(2009, 4, 104, 12, 11, '2025-04-02 10:00:00', '2025-04-02 11:00:00', 'abgeschlossen'),
(2010, 1, 106, 13, 12, '2025-04-03 08:15:00', '2025-04-03 09:00:00', 'abgeschlossen'),
(2011, 2, 105, 12, 10, '2025-04-04 09:30:00', '2025-04-04 10:15:00', 'abgeschlossen'),
(2012, 5, 100, 10, 11, '2025-04-05 11:00:00', '2025-04-05 11:40:00', 'abgeschlossen'),
(2013, 6, 102, 11, 13, '2025-04-06 12:00:00', '2025-04-06 13:00:00', 'abgeschlossen'),
-- Mai 2025
(2014, 1, 106, 13, 10, '2025-05-01 07:00:00', '2025-05-01 07:45:00', 'abgeschlossen'),
(2015, 3, 104, 12, 11, '2025-05-02 09:00:00', '2025-05-02 10:00:00', 'abgeschlossen'),
(2016, 4, 100, 10, 13, '2025-05-03 10:30:00', '2025-05-03 11:20:00', 'abgeschlossen'),
(2017, 5, 106, 13, 12, '2025-05-04 08:00:00', '2025-05-04 08:30:00', 'abgeschlossen'),
(2018, 2, 105, 12, 10, '2025-05-05 09:30:00', '2025-05-05 10:30:00', 'abgeschlossen'),
(2019, 6, 102, 11, 10, '2025-05-06 11:00:00', '2025-05-06 12:00:00', 'abgeschlossen'),
(2020, 1, 100, 10, 11, '2025-05-07 07:30:00', '2025-05-07 08:10:00', 'abgeschlossen');

-- ────────────────────────────────────────────────
--  WARTUNGEN
-- ────────────────────────────────────────────────
INSERT INTO wartungen VALUES
(3000, 103, '2025-03-05', 'Inspektion',      'Bremsen und Licht geprueft'),
(3001, 104, '2025-03-06', 'Sicherheitscheck','Rahmen und Reifen kontrolliert'),
(3002, 101, '2025-03-07', 'Reparatur',       'Akku-Stecker ersetzt'),
(3003, 103, '2025-04-15', 'Reparatur',       'Gangschaltung justiert'),
(3004, 100, '2025-04-20', 'Inspektion',      'Regulaere Wartung'),
(3005, 107, '2025-05-02', 'Sicherheitscheck','Reifen und Bremsen OK');

-- ────────────────────────────────────────────────
--  ZAHLUNGEN (19 Datensätze – nur abgeschlossene Ausleihen)
-- ────────────────────────────────────────────────
INSERT INTO zahlungen VALUES
-- März
(4000, 2000, 6.90, 'Karte',      '2025-03-10 09:07:00', 'bezahlt'),
(4001, 2001, 5.80, 'App',        '2025-03-10 10:02:00', 'bezahlt'),
(4002, 2003, 8.70, 'Lastschrift','2025-03-11 09:12:00', 'bezahlt'),
(4003, 2004, 6.30, 'Karte',      '2025-03-11 12:20:00', 'bezahlt'),
(4004, 2005, 4.20, 'App',        '2025-03-12 08:12:00', 'bezahlt'),
(4005, 2007, 4.50, 'Karte',      '2025-03-12 13:10:00', 'bezahlt'),
-- April
(4006, 2008, 5.00, 'App',        '2025-04-01 08:21:00', 'bezahlt'),
(4007, 2009, 7.25, 'Karte',      '2025-04-02 11:01:00', 'bezahlt'),
(4008, 2010, 3.15, 'App',        '2025-04-03 09:01:00', 'bezahlt'),
(4009, 2011, 5.25, 'Lastschrift','2025-04-04 10:16:00', 'bezahlt'),
(4010, 2012, 3.50, 'Karte',      '2025-04-05 11:41:00', 'bezahlt'),
(4011, 2013, 5.00, 'App',        '2025-04-06 13:01:00', 'bezahlt'),
-- Mai
(4012, 2014, 3.15, 'Karte',      '2025-05-01 07:46:00', 'bezahlt'),
(4013, 2015, 7.25, 'Lastschrift','2025-05-02 10:01:00', 'bezahlt'),
(4014, 2016, 3.50, 'App',        '2025-05-03 11:21:00', 'bezahlt'),
(4015, 2017, 2.10, 'Karte',      '2025-05-04 08:31:00', 'bezahlt'),
(4016, 2018, 5.25, 'Lastschrift','2025-05-05 10:31:00', 'bezahlt'),
(4017, 2019, 5.00, 'App',        '2025-05-06 12:01:00', 'bezahlt'),
(4018, 2020, 3.50, 'Karte',      '2025-05-07 08:11:00', 'bezahlt');
