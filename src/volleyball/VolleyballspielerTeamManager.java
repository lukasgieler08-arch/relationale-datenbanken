package volleyball;

import java.util.ArrayList;

/**
 * Model-Klasse: Verwaltet alle Spielerlisten des Volleyball-Teams.
 *
 * <p>Enthält die gesamte Geschäftslogik (Business Logic) des Team-Managers:</p>
 * <ul>
 *   <li>Verwaltung der Startaufstellung ({@link Kaderspieler})</li>
 *   <li>Verwaltung der Ersatzspieler ({@link Ersatzspieler})</li>
 *   <li>Tauschen von Spielerpositionen</li>
 *   <li>Einfügen neuer Spieler</li>
 *   <li>Kaderübersicht (alle Spieler kombiniert)</li>
 * </ul>
 *
 * <p><strong>MVC-Rolle:</strong> Model – enthält keine UI-Logik.</p>
 *
 * <p><strong>Assoziation:</strong> Dieser Manager wird einmalig im {@link MainWindow}
 * erzeugt und als gemeinsame Instanz an alle Sub-Fenster weitergegeben.</p>
 */
public class VolleyballspielerTeamManager {

    /** Liste der Kaderspieler (aktive Startaufstellung) */
    private final ArrayList<Kaderspieler> startaufstellung;

    /** Liste der Ersatzspieler (Ersatzbank) */
    private final ArrayList<Ersatzspieler> ersatzBank;

    // ---- Konstruktor ----

    /**
     * Standard-Konstruktor: Initialisiert die Listen mit Standard-Spielern.
     */
    public VolleyballspielerTeamManager() {
        startaufstellung = new ArrayList<>();
        startaufstellung.add(new Kaderspieler("Armin"));
        startaufstellung.add(new Kaderspieler("Batu"));
        startaufstellung.add(new Kaderspieler("Kai"));
        startaufstellung.add(new Kaderspieler("Sven"));
        startaufstellung.add(new Kaderspieler("Paul"));
        startaufstellung.add(new Kaderspieler("Milan"));

        ersatzBank = new ArrayList<>();
        ersatzBank.add(new Ersatzspieler("Chris"));
        ersatzBank.add(new Ersatzspieler("Dennis"));
        ersatzBank.add(new Ersatzspieler("Emin"));
        ersatzBank.add(new Ersatzspieler("Goran"));
        ersatzBank.add(new Ersatzspieler("Luca"));
        ersatzBank.add(new Ersatzspieler("Nico"));
    }

    // ---- Lesender Zugriff ----

    /**
     * Gibt die Startaufstellung zurück.
     *
     * @return ArrayList der Kaderspieler
     */
    public ArrayList<Kaderspieler> getStartaufstellung() {
        return new ArrayList<>(startaufstellung);
    }

    /**
     * Gibt die Ersatzbank zurück.
     *
     * @return ArrayList der Ersatzspieler
     */
    public ArrayList<Ersatzspieler> getErsatzBank() {
        return new ArrayList<>(ersatzBank);
    }

    /**
     * Gibt die Spielerliste anhand der Auswahl-Nummer zurück.
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler
     * @return Die entsprechende Spielerliste oder {@code null} bei ungültiger Auswahl
     */
    public ArrayList<? extends Spieler> holeSpielerliste(int auswahl) {
        switch (auswahl) {
            case 1: return startaufstellung;
            case 2: return ersatzBank;
            default: return new ArrayList<>();
        }
    }

    // ---- Geschäftslogik ----

    /**
     * Tauscht zwei Spieler an den angegebenen Positionen innerhalb einer Liste.
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler
     * @param von     Index des ersten Spielers (0-basiert)
     * @param nach    Index des zweiten Spielers (0-basiert)
     */
    public void tausche(int auswahl, int von, int nach) {
        if (auswahl == 1) {
            tauschen(startaufstellung, von, nach);
        } else if (auswahl == 2) {
            tauschen(ersatzBank, von, nach);
        }
    }

    /**
     * Generische Hilfsmethode: Tauscht zwei Elemente in einer ArrayList.
     *
     * @param liste Die Liste, in der getauscht wird
     * @param von   Index des ersten Elements (0-basiert)
     * @param nach  Index des zweiten Elements (0-basiert)
     * @param <T>   Spieler-Typ (Kaderspieler oder Ersatzspieler)
     */
    private <T extends Spieler> void tauschen(ArrayList<T> liste, int von, int nach) {
        if (von >= 0 && nach >= 0 && von < liste.size() && nach < liste.size()) {
            T zwischenspeicher = liste.get(von);
            liste.set(von, liste.get(nach));
            liste.set(nach, zwischenspeicher);
        }
    }

    /**
     * Fügt einen neuen Spieler an der angegebenen Position in eine Liste ein.
     *
     * @param auswahl     1 = Startaufstellung, 2 = Ersatzspieler
     * @param spielerName Name des neuen Spielers
     * @param stelle      Einfügeposition (0-basiert)
     */
    public void einfuegen(int auswahl, String spielerName, int stelle) {
        if (auswahl == 1) {
            startaufstellung.add(stelle, new Kaderspieler(spielerName));
        } else if (auswahl == 2) {
            ersatzBank.add(stelle, new Ersatzspieler(spielerName));
        }
    }

    /**
     * Gibt den gesamten Kader zurück: Startaufstellung + Ersatzspieler.
     *
     * @return ArrayList aller Spieler im Kader
     */
    public ArrayList<Spieler> getKader() {
        ArrayList<Spieler> kader = new ArrayList<>();
        kader.addAll(startaufstellung);
        kader.addAll(ersatzBank);
        return kader;
    }

    // ---- Ausgabe-Methoden ----

    /**
     * Erstellt einen formatierten String der Startaufstellung.
     *
     * @return Zeilenweise Auflistung der Kaderspieler
     */
    public String zeigeStartaufstellung() {
        return spielerlisteAlsString(startaufstellung);
    }

    /**
     * Erstellt einen formatierten String der Ersatzspieler.
     *
     * @return Zeilenweise Auflistung der Ersatzspieler
     */
    public String zeigeErsatzspieler() {
        return spielerlisteAlsString(ersatzBank);
    }

    /**
     * Erstellt einen formatierten String des gesamten Kaders.
     *
     * @return Zeilenweise Auflistung aller Kadermitglieder
     */
    public String zeigeKader() {
        return spielerlisteAlsString(getKader());
    }

    /**
     * Hilfsmethode: Wandelt eine Spielerliste in einen zeilengetrennten String um.
     *
     * @param liste Die zu formatierende Spielerliste
     * @return Zeilengetrennter String aller Spielernamen
     */
    private String spielerlisteAlsString(ArrayList<? extends Spieler> liste) {
        StringBuilder sb = new StringBuilder();
        for (Spieler spieler : liste) {
            sb.append(spieler.getName()).append("\n");
        }
        return sb.toString();
    }
}
