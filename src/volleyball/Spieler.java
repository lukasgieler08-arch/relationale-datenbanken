package volleyball;

/**
 * Abstrakte Basisklasse für alle Volleyball-Spieler.
 *
 * <p>Definiert die gemeinsame Schnittstelle und die gemeinsamen Eigenschaften
 * aller Spieler-Typen nach dem Prinzip der Vererbung (OOP).</p>
 *
 * <p>Unterklassen: {@link Kaderspieler}, {@link Ersatzspieler}</p>
 */
public abstract class Spieler {

    /** Name des Spielers */
    private String name;

    /**
     * Konstruktor mit Namensparameter.
     *
     * @param name Der Name des Spielers
     */
    public Spieler(String name) {
        this.name = name;
    }

    /**
     * Gibt den Namen des Spielers zurück.
     *
     * @return Name des Spielers
     */
    public String getName() {
        return name;
    }

    /**
     * Setzt den Namen des Spielers.
     *
     * @param name Der neue Name des Spielers
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gibt den Spieler-Typ als Text zurück.
     * Muss von jeder konkreten Unterklasse implementiert werden.
     *
     * @return Typ-Bezeichnung des Spielers (z.B. "Kaderspieler", "Ersatzspieler")
     */
    public abstract String getSpielerTyp();

    /**
     * Gibt eine lesbare Darstellung des Spielers zurück.
     *
     * @return Name des Spielers
     */
    @Override
    public String toString() {
        return name;
    }
}
