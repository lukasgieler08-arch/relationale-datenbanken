package volleyball;

import java.util.ArrayList;

/**
 * Headless-Smoke-Test fuer den VolleyballspielerTeamManager.
 *
 * <p>Testet alle Kernfunktionen der Modell-Klasse ohne GUI und ohne Display.
 * Geeignet fuer Codespace, CI-Pipelines und terminalbasierte Live-Tests.</p>
 *
 * <p>Aufruf: {@code java -cp build/java volleyball.ModelSmokeTest}</p>
 * <p>Exit-Code 0 = alle Tests bestanden, Exit-Code 1 = Fehler.</p>
 */
public class ModelSmokeTest {

    private static int passed = 0;
    private static int failed = 0;

    public static void main(String[] args) {
        System.out.println("[java-model-test] Starte Volleyball-Modell-Smoke-Tests...");
        System.out.println("------------------------------------------------------------");

        testStartaufstellungInitialisierung();
        testErsatzbankInitialisierung();
        testKaderGesamtgroesse();
        testTauschen();
        testEinfuegen();
        testGetKader();
        testUngueltiger_Tausch_keinFehler();
        testHoleSpielerlisteUngueltig();

        System.out.println("------------------------------------------------------------");
        System.out.printf("[java-model-test] Ergebnis: %d bestanden, %d fehlgeschlagen%n",
                passed, failed);

        if (failed > 0) {
            System.exit(1);
        }
        System.out.println("[java-model-test] Alle Tests erfolgreich");
    }

    // ---- Testmethoden ----

    private static void testStartaufstellungInitialisierung() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        ArrayList<Kaderspieler> start = m.getStartaufstellung();
        assertEqual("Startaufstellung hat 6 Spieler", 6, start.size());
        assertEqual("Erster Spieler ist Armin", "Armin", start.get(0).getName());
    }

    private static void testErsatzbankInitialisierung() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        ArrayList<Ersatzspieler> bank = m.getErsatzBank();
        assertEqual("Ersatzbank hat 6 Spieler", 6, bank.size());
        assertEqual("Erster Ersatzspieler ist Chris", "Chris", bank.get(0).getName());
    }

    private static void testKaderGesamtgroesse() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        assertEqual("Kader hat 12 Spieler gesamt", 12, m.getKader().size());
    }

    private static void testTauschen() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        String vor  = m.getStartaufstellung().get(0).getName(); // Armin
        String nach = m.getStartaufstellung().get(1).getName(); // Batu
        m.tausche(1, 0, 1);
        assertEqual("Nach Tausch ist Index 0 = Batu", nach,
                m.getStartaufstellung().get(0).getName());
        assertEqual("Nach Tausch ist Index 1 = Armin", vor,
                m.getStartaufstellung().get(1).getName());
    }

    private static void testEinfuegen() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        m.einfuegen(1, "TestSpieler", 0);
        assertEqual("Nach Einfuegen hat Startaufstellung 7 Spieler",
                7, m.getStartaufstellung().size());
        assertEqual("Eingefuegter Spieler ist an Position 0", "TestSpieler",
                m.getStartaufstellung().get(0).getName());
    }

    private static void testGetKader() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        ArrayList<Spieler> kader = m.getKader();
        assertEqual("Kader enthaelt Kaderspieler-Typ an Position 0",
                "Kaderspieler", kader.get(0).getSpielerTyp());
        assertEqual("Kader enthaelt Ersatzspieler-Typ an Position 6",
                "Ersatzspieler", kader.get(6).getSpielerTyp());
    }

    private static void testUngueltiger_Tausch_keinFehler() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        // Ungueltige Indizes duerfen keine Exception werfen
        try {
            m.tausche(1, -1, 999);
            pass("Ungueltiger Tausch wirft keine Exception");
        } catch (Exception e) {
            fail("Ungueltiger Tausch wirft unexpectedly Exception: " + e.getMessage());
        }
    }

    private static void testHoleSpielerlisteUngueltig() {
        VolleyballspielerTeamManager m = new VolleyballspielerTeamManager();
        assertEqual("holeSpielerliste(99) gibt leere Liste zurueck",
                0, m.holeSpielerliste(99).size());
    }

    // ---- Assertions ----

    private static void assertEqual(String beschreibung, Object erwartet, Object tatsaechlich) {
        if (erwartet.equals(tatsaechlich)) {
            pass(beschreibung);
        } else {
            fail(beschreibung + " [erwartet: " + erwartet + ", war: " + tatsaechlich + "]");
        }
    }

    private static void pass(String beschreibung) {
        System.out.println("  PASS  " + beschreibung);
        passed++;
    }

    private static void fail(String beschreibung) {
        System.out.println("  FAIL  " + beschreibung);
        failed++;
    }
}
