-- ============================================================
--  foodtrucknetz_uebung_daten.sql
--  Eigenständiger Datendump für die Übungsreihe (erweitert)
--  Kontext: FoodTruckNetz (6 Entitätstypen, Schuljahr 2025)
--  Enthält die originalen + erweiterten Datensätze für
--  Übungen zu JOIN, WHERE, AND/OR, GROUP BY, HAVING,
--  Aggregatfunktionen und Datumsfunktionen.
--  WICHTIG: Struktur-Dump zuerst einlesen!
--  > mysql -u root -p < ../klassenarbeiten/foodtrucknetz_struktur_2025.sql
--  Dann diese Datei:
--  > mysql -u root -p < daten/foodtrucknetz_uebung_daten.sql
-- ============================================================

USE foodtrucknetzdb_2025;

-- Vorhandene Daten sicher leeren (Reihenfolge wegen FK)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE zahlungen;
TRUNCATE TABLE bestellungen;
TRUNCATE TABLE produkte;
TRUNCATE TABLE trucks;
TRUNCATE TABLE standorte;
TRUNCATE TABLE kunden;
SET FOREIGN_KEY_CHECKS = 1;

-- ────────────────────────────────────────────────
--  KUNDEN (12 Datensätze)
-- ────────────────────────────────────────────────
INSERT INTO kunden VALUES
(1,  'Mara',  'Klein',    'Gold',   '2024-01-08', 1),
(2,  'Nico',  'Brandt',   'Silber', '2024-01-15', 1),
(3,  'Omar',  'Saad',     'Bronze', '2024-02-03', 1),
(4,  'Pia',   'Lorenz',   'Silber', '2024-02-21', 1),
(5,  'Quin',  'Roth',     'Gold',   '2024-03-10', 1),
(6,  'Rina',  'Pham',     'Bronze', '2024-03-28', 1),
(7,  'Sven',  'Koch',     'Silber', '2024-04-15', 1),
(8,  'Tara',  'Fuchs',    'Gold',   '2024-05-01', 1),
(9,  'Uwe',   'Lehmann',  'Bronze', '2024-06-10', 0),
(10, 'Vera',  'Schubert', 'Silber', '2024-07-22', 1),
(11, 'Willi', 'Braun',    'Gold',   '2024-08-05', 1),
(12, 'Xenia', 'Mueller',  'Bronze', '2024-09-18', 1);

-- ────────────────────────────────────────────────
--  STANDORTE
-- ────────────────────────────────────────────────
INSERT INTO standorte VALUES
(10, 'Innenstadt',    'Mitte', 1),
(11, 'Campuspark',    'Nord',  1),
(12, 'Seepromenade',  'West',  1);

-- ────────────────────────────────────────────────
--  TRUCKS
-- ────────────────────────────────────────────────
INSERT INTO trucks VALUES
(100, 10, 'Urban Bites',   'offen'),
(101, 11, 'Campus Curry',  'offen'),
(102, 12, 'Lake Tacos',    'wartung');

-- ────────────────────────────────────────────────
--  PRODUKTE
-- ────────────────────────────────────────────────
INSERT INTO produkte VALUES
(200, 100, 'Falafel Wrap', 'Wrap',  7.50, 1),
(201, 100, 'Pommes Box',   'Snack', 4.00, 1),
(202, 101, 'Veggie Bowl',  'Bowl',  8.20, 1),
(203, 101, 'Linsensuppe',  'Suppe', 5.60, 1),
(204, 102, 'Fish Taco',    'Taco',  6.80, 0),
(205, 102, 'Mais Taco',    'Taco',  6.20, 1);

-- ────────────────────────────────────────────────
--  BESTELLUNGEN (25 Datensätze – März, April, Mai 2025)
-- ────────────────────────────────────────────────
INSERT INTO bestellungen VALUES
-- März 2025
(3000, 1, 100, 200, '2025-03-10 12:10:00', 'abgeschlossen'),
(3001, 2, 100, 201, '2025-03-10 12:18:00', 'abgeschlossen'),
(3002, 1, 101, 202, '2025-03-11 13:05:00', 'abgeschlossen'),
(3003, 3, 101, 203, '2025-03-11 13:20:00', 'neu'),
(3004, 4, 100, 200, '2025-03-12 11:55:00', 'abgeschlossen'),
(3005, 5, 101, 202, '2025-03-12 12:40:00', 'abgeschlossen'),
-- April 2025
(3006, 7, 100, 201, '2025-04-01 11:00:00', 'abgeschlossen'),
(3007, 8, 101, 202, '2025-04-02 12:30:00', 'abgeschlossen'),
(3008, 1, 101, 203, '2025-04-03 13:15:00', 'abgeschlossen'),
(3009, 2, 102, 204, '2025-04-04 09:00:00', 'storniert'),
(3010, 3, 100, 200, '2025-04-05 10:20:00', 'abgeschlossen'),
(3011, 4, 101, 202, '2025-04-06 14:00:00', 'abgeschlossen'),
-- Mai 2025 – Trucks 100/101
(3012, 5, 100, 201, '2025-05-01 09:30:00', 'abgeschlossen'),
(3013, 6, 101, 203, '2025-05-02 11:45:00', 'abgeschlossen'),
(3014, 7, 102, 205, '2025-05-03 12:00:00', 'neu'),
(3015, 8, 100, 200, '2025-05-04 13:00:00', 'abgeschlossen'),
(3016, 1, 100, 201, '2025-05-05 08:50:00', 'abgeschlossen'),
(3017,10, 101, 202, '2025-05-06 10:00:00', 'abgeschlossen'),
(3018,11, 100, 200, '2025-05-07 11:30:00', 'abgeschlossen'),
(3019,12, 101, 203, '2025-05-08 12:15:00', 'abgeschlossen'),
(3020, 3, 100, 200, '2025-05-09 09:00:00', 'abgeschlossen'),
-- Mai 2025 – Truck 102 (Lake Tacos)
(3021, 4, 102, 205, '2025-05-10 12:00:00', 'abgeschlossen'),
(3022, 5, 102, 205, '2025-05-11 13:00:00', 'abgeschlossen'),
(3023, 6, 102, 205, '2025-05-12 11:00:00', 'abgeschlossen'),
(3024, 7, 102, 205, '2025-05-13 12:00:00', 'abgeschlossen');

-- ────────────────────────────────────────────────
--  ZAHLUNGEN (22 Datensätze – nur abgeschlossene Bestellungen)
-- ────────────────────────────────────────────────
INSERT INTO zahlungen VALUES
-- März
(4000, 3000, 7.50, 'Karte', '2025-03-10 12:11:00', 'bezahlt'),
(4001, 3001, 4.00, 'App',   '2025-03-10 12:19:00', 'bezahlt'),
(4002, 3002, 8.20, 'Bar',   '2025-03-11 13:06:00', 'bezahlt'),
(4003, 3004, 7.50, 'Karte', '2025-03-12 11:56:00', 'bezahlt'),
(4004, 3005, 8.20, 'App',   '2025-03-12 12:41:00', 'bezahlt'),
-- April
(4005, 3006, 4.00, 'Bar',   '2025-04-01 11:01:00', 'bezahlt'),
(4006, 3007, 8.20, 'Karte', '2025-04-02 12:31:00', 'bezahlt'),
(4007, 3008, 5.60, 'App',   '2025-04-03 13:16:00', 'bezahlt'),
(4008, 3010, 7.50, 'Bar',   '2025-04-05 10:21:00', 'bezahlt'),
(4009, 3011, 8.20, 'Karte', '2025-04-06 14:01:00', 'bezahlt'),
-- Mai Trucks 100/101
(4010, 3012, 4.00, 'App',   '2025-05-01 09:31:00', 'bezahlt'),
(4011, 3013, 5.60, 'Bar',   '2025-05-02 11:46:00', 'bezahlt'),
(4012, 3015, 7.50, 'Karte', '2025-05-04 13:01:00', 'bezahlt'),
(4013, 3016, 4.00, 'App',   '2025-05-05 08:51:00', 'bezahlt'),
(4014, 3017, 8.20, 'Karte', '2025-05-06 10:01:00', 'bezahlt'),
(4015, 3018, 7.50, 'App',   '2025-05-07 11:31:00', 'bezahlt'),
(4016, 3019, 5.60, 'Bar',   '2025-05-08 12:16:00', 'bezahlt'),
(4017, 3020, 7.50, 'Karte', '2025-05-09 09:01:00', 'bezahlt'),
-- Mai Truck 102
(4018, 3021, 6.20, 'App',   '2025-05-10 12:01:00', 'bezahlt'),
(4019, 3022, 6.20, 'Bar',   '2025-05-11 13:01:00', 'bezahlt'),
(4020, 3023, 6.20, 'Karte', '2025-05-12 11:01:00', 'bezahlt'),
(4021, 3024, 6.20, 'App',   '2025-05-13 12:01:00', 'bezahlt');
