package volleyball;

import java.util.ArrayList;

/**
 * Controller-Klasse: Vermittler zwischen View und Model.
 *
 * <p>Der Controller übernimmt folgende Aufgaben:</p>
 * <ul>
 *   <li><strong>Eingabevalidierung</strong>: Prüft alle Benutzereingaben bevor
 *       sie an das Model weitergegeben werden. Gibt fehlerhafte Eingaben
 *       mit einer aussagekräftigen Fehlermeldung zurück.</li>
 *   <li><strong>Weitergabe an Model</strong>: Leitet geprüfte Eingaben an
 *       {@link VolleyballspielerTeamManager} weiter (Schreib-Operationen).</li>
 *   <li><strong>Datenabruf für View</strong>: Holt verarbeitete Daten aus dem
 *       Model und gibt sie in einem für die View nutzbaren Format zurück
 *       (Lese-Operationen).</li>
 * </ul>
 *
 * <p><strong>MVC-Rolle:</strong> Controller – kennt weder UI-Komponenten noch
 * Layout-Details. Kommuniziert ausschließlich über primitive Typen und
 * {@link String}. Wirft {@link IllegalArgumentException} mit benutzerlesbaren
 * Meldungen, damit die View diese direkt in einem Dialog anzeigen kann.</p>
 *
 * <p><strong>Assoziation:</strong> Wird einmalig in {@link MainWindow} erzeugt
 * und an alle Sub-Windows weitergegeben.</p>
 */
public class TeamManagerController {

    /** Das Model – enthält alle Spielerdaten und Geschäftslogik */
    private final VolleyballspielerTeamManager manager;

    // ---- Konstruktor ----

    /**
     * Erzeugt den Controller mit dem übergebenen Model.
     *
     * @param manager Die gemeinsame Manager-Instanz (Model)
     */
    public TeamManagerController(VolleyballspielerTeamManager manager) {
        this.manager = manager;
    }

    // ---- Auswahl-Validierung ----

    /**
     * Validiert die Rohauswahl aus der View gegen die erlaubten Optionen einer Aktion.
     *
     * <p>Die View liest den UI-Zustand (welcher RadioButton ist aktiv) und übergibt
     * die rohe Auswahl. Der Controller prüft, ob diese Auswahl für die angeforderte
     * Aktion semantisch gültig ist.</p>
     *
     * @param rohAuswahl    Rohwert aus der View: 0 = nichts gewählt, 1 = Startaufstellung,
     *                      2 = Ersatzspieler, 3 = Kader
     * @param startErlaubt  {@code true}, wenn Startaufstellung für diese Aktion zulässig ist
     * @param ersatzErlaubt {@code true}, wenn Ersatzspieler für diese Aktion zulässig ist
     * @param kaderErlaubt  {@code true}, wenn Kader für diese Aktion zulässig ist
     * @return Validierter Auswahl-Wert (≥1)
     * @throws IllegalArgumentException mit benutzerlesbarer Meldung bei ungültiger Auswahl
     */
    public int validierteAuswahl(int rohAuswahl, boolean startErlaubt,
                                  boolean ersatzErlaubt, boolean kaderErlaubt) {
        if (rohAuswahl == 0) {
            throw new IllegalArgumentException("Bitte wählen Sie eine Option aus!");
        }

        boolean erlaubt = (rohAuswahl == 1 && startErlaubt)
                       || (rohAuswahl == 2 && ersatzErlaubt)
                       || (rohAuswahl == 3 && kaderErlaubt);

        if (!erlaubt) {
            throw new IllegalArgumentException(
                "Diese Option ist für die gewählte Aktion nicht verfügbar.\n"
                + "Bitte wählen Sie Startaufstellung oder Ersatzspieler.");
        }

        return rohAuswahl;
    }

    // ---- Datenabruf für View (Lese-Operationen) ----

    /**
     * Gibt die formatierte Spielerliste für die gewählte Kategorie zurück.
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler, 3 = Kader
     * @return Zeilenweise Spielerliste als String
     */
    public String getAusgabe(int auswahl) {
        switch (auswahl) {
            case 1: return manager.zeigeStartaufstellung();
            case 2: return manager.zeigeErsatzspieler();
            case 3: return manager.zeigeKader();
            default: return "";
        }
    }

    /**
     * Gibt die Anzahl der Spieler in der gewählten Liste zurück.
     * Wird z.B. von Views benötigt, um ComboBoxen dynamisch zu befüllen.
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler
     * @return Anzahl der Spieler, oder 0 bei ungültiger Auswahl
     */
    public int getListengroesse(int auswahl) {
        ArrayList<? extends Spieler> liste = manager.holeSpielerliste(auswahl);
        return liste != null ? liste.size() : 0;
    }

    /**
     * Erstellt ein String-Array für ComboBox-Einträge (1-basierte Positionsbezeichnungen).
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler
     * @return Array der Positionsbezeichnungen, z.B. ["1", "2", ..., "6"]
     */
    public String[] getPositionsNamen(int auswahl) {
        int groesse = getListengroesse(auswahl);
        String[] positionen = new String[groesse];
        for (int i = 0; i < groesse; i++) {
            positionen[i] = String.valueOf(i + 1);
        }
        return positionen;
    }

    // ---- Weitergabe an Model (Schreib-Operationen) ----

    /**
     * Validiert die Eingaben und fügt einen neuen Spieler in die gewählte Liste ein.
     *
     * <p>Validierungsregeln:</p>
     * <ul>
     *   <li>Spielername darf nicht leer sein</li>
     *   <li>Stelle muss eine gültige Ganzzahl sein</li>
     *   <li>Stelle muss im Bereich [0, Listengröße] liegen</li>
     * </ul>
     *
     * @param auswahl      1 = Startaufstellung, 2 = Ersatzspieler
     * @param spielerName  Name des neuen Spielers (Rohtext aus der View)
     * @param stelleText   Position als Text-Eingabe aus der View
     * @throws IllegalArgumentException mit benutzerlesbarer Meldung bei Validierungsfehler
     */
    public void einfuegen(int auswahl, String spielerName, String stelleText) {
        // Spielername validieren
        String name = spielerName == null ? "" : spielerName.trim();
        if (name.isEmpty()) {
            throw new IllegalArgumentException("Bitte geben Sie einen Spielernamen ein.");
        }

        // Stelle validieren: muss eine Ganzzahl sein
        int stelle;
        try {
            stelle = Integer.parseInt(stelleText == null ? "" : stelleText.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Bitte eine gültige Zahl für die Stelle eingeben.");
        }

        // Stelle validieren: muss im erlaubten Bereich liegen
        int maxStelle = getListengroesse(auswahl);
        if (stelle < 0 || stelle > maxStelle) {
            throw new IllegalArgumentException(
                "Ungültige Stelle. Erlaubter Bereich: 0 bis " + maxStelle + ".");
        }

        // Geprüfte Eingabe an Model weitergeben
        manager.einfuegen(auswahl, name, stelle);
    }

    /**
     * Leitet den Tausch zweier Spielerpositionen an das Model weiter.
     *
     * <p>Die Positions-Indices kommen 0-basiert aus der View (ComboBox-Index)
     * und werden direkt an das Model delegiert.</p>
     *
     * @param auswahl 1 = Startaufstellung, 2 = Ersatzspieler
     * @param von     0-basierter Index des ersten Spielers
     * @param nach    0-basierter Index des zweiten Spielers
     */
    public void tauschen(int auswahl, int von, int nach) {
        manager.tausche(auswahl, von, nach);
    }
}
