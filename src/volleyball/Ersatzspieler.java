package volleyball;

/**
 * Repräsentiert einen Ersatzspieler des Volleyball-Teams.
 *
 * <p>Erbt die gemeinsamen Eigenschaften von der abstrakten Klasse {@link Spieler}.
 * Ersatzspieler befinden sich auf der Ersatzbank und können eingewechselt werden.</p>
 */
public class Ersatzspieler extends Spieler {

    /**
     * Konstruktor mit Namensparameter.
     *
     * @param name Der Name des Ersatzspielers
     */
    public Ersatzspieler(String name) {
        super(name);
    }

    /**
     * {@inheritDoc}
     *
     * @return "Ersatzspieler"
     */
    @Override
    public String getSpielerTyp() {
        return "Ersatzspieler";
    }
}
