package volleyball;

import java.awt.Font;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;

/**
 * View-Klasse: Zeigt die Spieler einer gewählten Kategorie an.
 *
 * <p>Dieses Fenster ist rein-lesend (keine Bearbeitungsfunktion) und
 * zeigt je nach Auswahl die Startaufstellung, die Ersatzspieler oder
 * den gesamten Kader an.</p>
 *
 * <p><strong>MVC-Rolle:</strong> View – delegiert alle Datenanfragen
 * an den {@link TeamManagerController} (Controller), der seinerseits
 * das Model ({@link VolleyballspielerTeamManager}) befragt.</p>
 */
public class SpielerWindow extends JFrame {

    private static final long serialVersionUID = 1L;

    // ---- UI-Komponenten ----
    private JPanel contentPane;
    private JLabel lbTitel;
    private JScrollPane scrollPane;
    private JTextArea taAusgabe;

    /** Referenz auf den gemeinsamen Controller */
    private final TeamManagerController controller;

    /** Gewählte Kategorie: 1 = Startaufstellung, 2 = Ersatzspieler, 3 = Kader */
    private final int auswahl;

    // ---- Konstruktor ----

    /**
     * Erstellt das Anzeige-Fenster für die gewählte Spieler-Kategorie.
     *
     * @param controller Der gemeinsame Controller
     * @param auswahl    Kategorie: 1 = Startaufstellung, 2 = Ersatzspieler, 3 = Kader
     */
    public SpielerWindow(TeamManagerController controller, int auswahl) {
        this.controller = controller;
        this.auswahl = auswahl;
        initUI();
        anzeigeAktualisieren();
    }

    // ---- UI-Initialisierung ----

    /**
     * Baut alle UI-Komponenten des Fensters auf.
     */
    private void initUI() {
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setBounds(100, 100, 242, 293);

        contentPane = new JPanel();
        contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
        contentPane.setLayout(null);
        setContentPane(contentPane);

        lbTitel = new JLabel("Spieler anzeigen");
        lbTitel.setFont(new Font("Tahoma", Font.PLAIN, 20));
        lbTitel.setBounds(10, 11, 210, 25);
        contentPane.add(lbTitel);

        taAusgabe = new JTextArea();
        taAusgabe.setEditable(false);
        scrollPane = new JScrollPane(taAusgabe);
        scrollPane.setBounds(22, 68, 169, 93);
        contentPane.add(scrollPane);

        JLabel lbBanner = new JLabel("");
        lbBanner.setIcon(new ImageIcon(SpielerWindow.class.getResource("/image/logo_final.png")));
        lbBanner.setBounds(29, 213, 175, 30);
        contentPane.add(lbBanner);
    }

    // ---- Anzeigelogik ----

    /**
     * Aktualisiert Titel und Spielerliste entsprechend der gewählten Kategorie.
     */
    private void anzeigeAktualisieren() {
        String titel;
        String inhalt;

        switch (auswahl) {
            case 1:
                titel  = "Startaufstellung";
                inhalt = controller.getAusgabe(1);
                break;
            case 2:
                titel  = "Ersatzspieler";
                inhalt = controller.getAusgabe(2);
                break;
            case 3:
                titel  = "Kader";
                inhalt = controller.getAusgabe(3);
                break;
            default:
                titel  = "Spieler";
                inhalt = "";
        }

        lbTitel.setText(titel);
        taAusgabe.setText(inhalt);
    }
}
