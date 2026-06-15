package volleyball;

import java.awt.Font;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;

/**
 * View-Klasse: Fenster zum Tauschen zweier Spieler innerhalb einer Liste.
 *
 * <p>Der Benutzer wählt zwei Positionen (ComboBoxen) und klickt auf "Tauschen".
 * Die Vorher- und Nachher-Ansicht werden nebeneinander dargestellt.</p>
 *
 * <p><strong>MVC-Rolle:</strong> View – liest die gewählten Positionen aus
 * den ComboBoxen und delegiert Verarbeitung vollständig an den
 * {@link TeamManagerController} (Controller).</p>
 */
public class SpielerTauschWindow extends JFrame {

    private static final long serialVersionUID = 1L;

    // ---- UI-Komponenten ----
    private JPanel contentPane;
    private JComboBox<String> cbPositionenVon;
    private JComboBox<String> cbPositionenNach;
    private JTextArea taVorher;
    private JTextArea taNachher;

    /** Referenz auf den gemeinsamen Controller */
    private final TeamManagerController controller;

    /** Gewählte Kategorie: 1 = Startaufstellung, 2 = Ersatzspieler */
    private final int auswahl;

    // ---- Konstruktor ----

    /**
     * Erstellt das Tausch-Fenster für die gewählte Spieler-Kategorie.
     *
     * @param controller Der gemeinsame Controller
     * @param auswahl    1 = Startaufstellung, 2 = Ersatzspieler
     */
    public SpielerTauschWindow(TeamManagerController controller, int auswahl) {
        this.controller = controller;
        this.auswahl = auswahl;
        initUI();
        // View-Aufgabe: Vorher-Anzeige initial befüllen (Daten via Controller)
        taVorher.setText(controller.getAusgabe(auswahl));
    }

    // ---- UI-Initialisierung ----

    /**
     * Baut alle UI-Komponenten des Fensters auf.
     */
    private void initUI() {
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setBounds(100, 100, 450, 393);

        contentPane = new JPanel();
        contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
        contentPane.setLayout(null);
        setContentPane(contentPane);

        // Titel
        JLabel lbTitle = new JLabel("Spieler Tauschen");
        lbTitle.setFont(new Font("Tahoma", Font.PLAIN, 18));
        lbTitle.setIcon(new ImageIcon(SpielerTauschWindow.class.getResource("/image/ic_launcher.png")));
        lbTitle.setBounds(24, 11, 292, 78);
        contentPane.add(lbTitle);

        // Positions-Labels
        JLabel lbVon = new JLabel("Von Position:");
        lbVon.setBounds(33, 124, 89, 14);
        contentPane.add(lbVon);

        JLabel lbNach = new JLabel("Nach Position:");
        lbNach.setBounds(237, 124, 89, 14);
        contentPane.add(lbNach);

        // Positions-ComboBoxen: dynamisch aus der aktuellen Listengröße befüllt
        String[] positionen = controller.getPositionsNamen(auswahl);
        cbPositionenVon = new JComboBox<>(positionen);
        cbPositionenVon.setBounds(149, 120, 55, 22);
        contentPane.add(cbPositionenVon);

        cbPositionenNach = new JComboBox<>(positionen);
        cbPositionenNach.setBounds(351, 120, 55, 22);
        contentPane.add(cbPositionenNach);

        // Vorher/Nachher-Labels
        JLabel lbVorher = new JLabel("Vorher:");
        lbVorher.setBounds(34, 175, 73, 14);
        contentPane.add(lbVorher);

        JLabel lbNachher = new JLabel("Nachher:");
        lbNachher.setBounds(237, 175, 79, 14);
        contentPane.add(lbNachher);

        // Vorher-Anzeige
        taVorher = new JTextArea();
        taVorher.setEditable(false);
        JScrollPane spVorher = new JScrollPane(taVorher);
        spVorher.setBounds(33, 216, 139, 68);
        contentPane.add(spVorher);

        // Nachher-Anzeige
        taNachher = new JTextArea();
        taNachher.setEditable(false);
        JScrollPane spNachher = new JScrollPane(taNachher);
        spNachher.setBounds(237, 214, 154, 68);
        contentPane.add(spNachher);

        // Logo-Banner
        JLabel lbBanner = new JLabel("");
        lbBanner.setIcon(new ImageIcon(SpielerTauschWindow.class.getResource("/image/logo_final.png")));
        lbBanner.setBounds(256, 315, 170, 30);
        contentPane.add(lbBanner);

        // Tauschen-Button
        JButton btTauschen = new JButton("Tauschen");
        btTauschen.addActionListener(e -> onTauschenKlick());
        btTauschen.setBounds(33, 322, 139, 23);
        contentPane.add(btTauschen);
    }

    // ---- Hilfsmethoden ----

    // ---- Action-Handler ----

    /**
     * Verarbeitet den Klick auf den "Tauschen"-Button.
     *
     * <p><strong>View-Aufgabe</strong>: Gewählte Positionen aus den ComboBoxen
     * (0-basierter Index) lesen, Nachher-Anzeige aktualisieren.<br>
     * <strong>Controller-Aufgabe</strong>: Tausch ausführen und Ergebnis
     * zurückliefern (via {@link TeamManagerController#tauschen} +
     * {@link TeamManagerController#getAusgabe}).</p>
     */
    private void onTauschenKlick() {
        // View-Aufgabe: Positionen (0-basiert) aus ComboBoxen lesen
        int von  = cbPositionenVon.getSelectedIndex();
        int nach = cbPositionenNach.getSelectedIndex();

        // Controller-Aufgabe: Tausch delegieren
        controller.tauschen(auswahl, von, nach);

        // View-Aufgabe: Ergebnis aus Controller holen und anzeigen
        taNachher.setText(controller.getAusgabe(auswahl));
    }
}
