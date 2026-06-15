package volleyball;

/**
 * Repräsentiert einen Spieler der Startaufstellung (Kaderspieler).
 *
 * <p>Erbt die gemeinsamen Eigenschaften von der abstrakten Klasse {@link Spieler}.
 * Kaderspieler befinden sich in der aktiven Startaufstellung des Teams.</p>
 */
public class Kaderspieler extends Spieler {

    /**
     * Konstruktor mit Namensparameter.
     *
     * @param name Der Name des Kaderspielers
     */
    public Kaderspieler(String name) {
        super(name);
    }

    /**
     * {@inheritDoc}
     *
     * @return "Kaderspieler"
     */
    @Override
    public String getSpielerTyp() {
        return "Kaderspieler";
    }
}
