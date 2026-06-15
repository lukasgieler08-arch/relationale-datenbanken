package volleyball;

import java.awt.Font;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

/**
 * View-Klasse: Fenster zum Einfügen eines neuen Spielers in eine Liste.
 *
 * <p>Der Benutzer gibt einen Spielernamen und einen Index (0-basiert) ein.
 * Nach dem Klick auf ">>" wird der neue Spieler eingefügt und die Liste
 * aktualisiert angezeigt.</p>
 *
 * <p><strong>MVC-Rolle:</strong> View – liest UI-Eingaben und delegiert
 * Validierung und Verarbeitung vollständig an den
 * {@link TeamManagerController} (Controller).</p>
 */
public class SpielerEinfuegeWindow extends JFrame {

    private static final long serialVersionUID = 1L;

    // ---- UI-Komponenten ----
    private JPanel contentPane;
    private JTextField tfNeuerSpieler;
    private JTextField tfStelle;
    private JTextArea taAusgabe;

    /** Referenz auf den gemeinsamen Controller */
    private final TeamManagerController controller;

    /** Gewählte Kategorie: 1 = Startaufstellung, 2 = Ersatzspieler */
    private final int auswahl;

    // ---- Konstruktor ----

    /**
     * Erstellt das Einfüge-Fenster für die gewählte Spieler-Kategorie.
     *
     * @param controller Der gemeinsame Controller
     * @param auswahl    1 = Startaufstellung, 2 = Ersatzspieler
     */
    public SpielerEinfuegeWindow(TeamManagerController controller, int auswahl) {
        this.controller = controller;
        this.auswahl = auswahl;
        initUI();
    }

    // ---- UI-Initialisierung ----

    /**
     * Baut alle UI-Komponenten des Fensters auf.
     */
    private void initUI() {
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setBounds(100, 100, 450, 411);

        contentPane = new JPanel();
        contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
        contentPane.setLayout(null);
        setContentPane(contentPane);

        // Titel
        JLabel lbTitel = new JLabel("Spieler einfügen");
        lbTitel.setFont(new Font("Tahoma", Font.PLAIN, 18));
        lbTitel.setIcon(new ImageIcon(SpielerEinfuegeWindow.class.getResource("/image/ic_launcher.png")));
        lbTitel.setBounds(10, 0, 262, 81);
        contentPane.add(lbTitel);

        // Eingabe-Labels
        JLabel lbNeuerSpieler = new JLabel("Neuer Spieler:");
        lbNeuerSpieler.setBounds(24, 116, 96, 14);
        contentPane.add(lbNeuerSpieler);

        JLabel lbStelle = new JLabel("an der Stelle mit dem Index:");
        lbStelle.setBounds(24, 153, 201, 14);
        contentPane.add(lbStelle);

        // Eingabe-Textfelder
        tfNeuerSpieler = new JTextField();
        tfNeuerSpieler.setColumns(10);
        tfNeuerSpieler.setBounds(118, 113, 169, 20);
        contentPane.add(tfNeuerSpieler);

        tfStelle = new JTextField();
        tfStelle.setColumns(10);
        tfStelle.setBounds(248, 150, 39, 20);
        contentPane.add(tfStelle);

        // Einfügen-Button
        JButton btEinfuegen = new JButton(">>");
        btEinfuegen.addActionListener(e -> onEinfuegenKlick());
        btEinfuegen.setBounds(24, 198, 89, 23);
        contentPane.add(btEinfuegen);

        // Ausgabe-Bereich
        taAusgabe = new JTextArea();
        taAusgabe.setEditable(false);
        JScrollPane spAusgabe = new JScrollPane(taAusgabe);
        spAusgabe.setBounds(171, 197, 240, 160);
        contentPane.add(spAusgabe);

        // Logo-Banner
        JLabel lbBanner = new JLabel("");
        lbBanner.setIcon(new ImageIcon(SpielerEinfuegeWindow.class.getResource("/image/logo_final.png")));
        lbBanner.setBounds(249, 328, 175, 33);
        contentPane.add(lbBanner);
    }

    // ---- Controller-Methoden (Action-Handler) ----

    /**
     * Verarbeitet den Klick auf den ">>" Einfügen-Button.
     *
     * <p><strong>View-Aufgabe</strong>: Rohtext aus den Eingabefeldern lesen,
     * Fehlermeldung anzeigen, Ausgabe nach Erfolg aktualisieren.<br>
     * <strong>Controller-Aufgabe</strong>: Validierung und Weiterleitung
     * an das Model (via {@link TeamManagerController#einfuegen}).</p>
     */
    private void onEinfuegenKlick() {
        // View-Aufgabe: Rohtext aus Eingabefeldern übernehmen
        String rohName   = tfNeuerSpieler.getText();
        String rohStelle = tfStelle.getText();

        // Controller-Aufgabe: Validierung + Einfügen delegieren
        try {
            controller.einfuegen(auswahl, rohName, rohStelle);
        } catch (IllegalArgumentException ex) {
            JOptionPane.showMessageDialog(this, ex.getMessage());
            return;
        }

        // View-Aufgabe: Ausgabe nach Erfolg aktualisieren
        anzeigeAktualisieren();
    }

    /**
     * Aktualisiert die Spielerlisten-Anzeige nach einer Einfüge-Operation.
     */
    private void anzeigeAktualisieren() {
        taAusgabe.setText(controller.getAusgabe(auswahl));
    }
}
