# Klausurausarbeitung: Teil A & Teil B

---

## Aufgabe 1: Theorie (Multiple Choice)

Hier gehen wir jede Aussage einzeln durch und klären das Warum:

* **Aussage 1:** Ein Fremdschlüssel darf mehrfach vorkommen. $\rightarrow$ **RICHTIG (r)**
  * *Erklärung:* Ein Fremdschlüssel stellt die Verbindung zur "1"-Seite einer Beziehung her. Da ein Kunde viele Ausleihen tätigen kann (1:N), taucht dieselbe `kunde_id` völlig legal mehrfach in der Tabelle `ausleihen` auf.
* **Aussage 2:** Eine N:M-Beziehung wird in relationalen Modellen direkt ohne Zwischentabelle gespeichert. $\rightarrow$ **FALSCH (f)**
  * *Erklärung:* Relationale Datenbanken können N:M-Beziehungen nicht direkt in den Tabellen abbilden. Man benötigt zwingend eine Zwischentabelle, die die N:M-Beziehung in zwei 1:N-Beziehungen aufteilt (wie `KURS_LEHRKRAFT`).
* **Aussage 3:** Ein LEFT JOIN kann Datensätze ohne Partner auf der rechten Seite sichtbar machen. $\rightarrow$ **RICHTIG (r)**
  * *Erklärung:* Genau das ist der Hauptzweck des LEFT JOIN. Er behält alle Zeilen der linken Tabelle, und wenn rechts kein passender Partner existiert, werden die Spalten einfach mit NULL aufgefüllt.
* **Aussage 4:** Die 3NF reduziert Redundanz und Anomalien. $\rightarrow$ **RICHTIG (r)**
  * *Erklärung:* Das ist das Hauptziel der Normalisierung. Durch das Aufteilen von Daten in eigene Tabellen wird verhindert, dass Informationen mehrfach (redundant) gespeichert werden müssen, was wiederum Fehler (Anomalien) verhindert.
* **Aussage 5:** Ein Primärschlüssel darf NULL sein. $\rightarrow$ **FALSCH (f)**
  * *Erklärung:* Ein Primärschlüssel dient der eindeutigen Identifikation jeder einzelnen Zeile. Wäre er NULL (also leer oder unbekannt), könnte man den Datensatz nicht mehr eindeutig bestimmen. Es gilt die Regel: Primary Keys dürfen niemals NULL sein.
* **Aussage 6:** HAVING filtert Gruppen nach GROUP BY. $\rightarrow$ **RICHTIG (r)**
  * *Erklärung:* Während WHERE einzelne Zeilen filtert bevor gruppiert wird, greift HAVING erst im Anschluss und siebt die fertig berechneten Gruppen aus.

---

## Aufgabe 3.1: EERM modellieren (Kontext 1)

### Schritt-für-Schritt-Gedankengang
Der Text verlangt ein Modell für eine Kursplattform. Wir isolieren zuerst die Substantive (Objekte), um unsere Entitätstypen zu finden:
* "Teilnehmende buchen Kurse zu konkreten Terminen" $\rightarrow$ Wir brauchen **Teilnehmende**, **Kurse**, **Termine** und die Aktion **Buchung**.
* "Lehrkräfte betreuen Kurse, zum Teil im Team" $\rightarrow$ Wir brauchen **Lehrkräfte**. Da ein Kurs von mehreren Lehrkräften ("im Team") betreut werden kann und eine Lehrkraft bestimmt mehrere Kurse hat, entsteht hier eine N:M-Beziehung zwischen Kurs und Lehrkraft.

### Struktur der Tabellen (Das relationale Schema)
* **`teilnehmende`** (`teilnehmer_id` [PK], `vorname`, `nachname`, `email`)
* **`kurse`** (`kurs_id` [PK], `kurstitel`, `beschreibung`)
* **`termine`** (`termin_id` [PK], `kurs_id` [FK], `startdatum`, `enddatum`)
  * *Begründung:* Ein Kurs findet an konkreten Terminen statt (1:N). Daher wandert die `kurs_id` als Fremdschlüssel in die Termin-Tabelle.
* **`buchungen`** (`buchung_id` [PK], `teilnehmer_id` [FK], `termin_id` [FK])
  * *Begründung:* Die Buchung bringt den Teilnehmer und den konkreten Termin zusammen.
* **`lehrkraefte`** (`lehrkraft_id` [PK], `vorname`, `nachname`, `fachbereich`)
* **`kurs_lehrkraft`** (`kurs_id` [FK], `lehrkraft_id` [FK], PK aus beiden Spalten)
  * *Begründung:* Da Lehrkräfte im Team arbeiten können, müssen wir die N:M-Beziehung zwischen Kursen und Lehrkräften über diese Zwischentabelle auflösen.

---

## Aufgabe 3.2: Normalisierung bis 3NF

### 1. Benennung von 2 funktionellen Abhängigkeiten (FA)
Eine funktionelle Abhängigkeit bedeutet: Wenn ich den Wert A kenne, bestimmt dieser eindeutig den Wert B ($A \rightarrow B$).
* **FA 1:** `termin_id` $\rightarrow$ `kurs_id`
  * *Erklärung:* Wenn ich weiß, um welchen konkreten Einzeltermin es sich handelt, steht damit auch unabänderlich fest, welcher übergeordnete Kurs an diesem Termin stattfindet.
* **FA 2:** `teilnehmer_id` $\rightarrow$ `nachname`, `vorname`, `email`
  * *Erklärung:* Die ID ist eindeutig einer realen Person zugewiesen. Kenne ich die ID, kenne ich den exakten Namen.

### 2. Begründung, warum das Modell in 3NF liegt
Ein Modell ist in der 3. Normalform, wenn es die Bedingungen der 1. und 2. Normalform erfüllt und keine transitiven Abhängigkeiten besitzt (keine Nicht-Schlüsselattribute hängen von anderen Nicht-Schlüsselattributen ab).
* **Begründung:** Alle Attribute sind atomar (1NF). Jedes Nicht-Schlüsselattribut hängt voll funktional vom jeweiligen Primärschlüssel der Tabelle ab (2NF). Es gibt keine Spalte, die über den Umweg einer anderen Nicht-Schlüsselspalte bestimmt wird (3NF). Wenn sich z. B. ein Kurstitel ändert, muss er nur an exakt einer Stelle (Tabelle `kurse`) geändert werden.

---

## Aufgabe 3.3: Anomalien

Wenn man Daten unsauber in einer einzigen großen Tabelle speichert, treten diese drei klassischen Probleme auf:

* **Einfügeanomalie:**
  * *Beispiel:* Wir stellen eine neue Lehrkraft ein, die aber noch keinen Kurs zugeteilt bekommen hat. Wenn wir Lehrkräfte und Kurse in einer gemeinsamen Tabelle speichern, können wir die Lehrkraft gar nicht im System anlegen, da die Kurs-Felder (die zum Primärschlüssel gehören könnten) leer bleiben müssten.
* **Änderungsanomalie:**
  * *Beispiel:* Ein Kurstitel ändert sich von "SQL-Grundlagen" in "Relationales SQL". Liegen die Daten denormalisiert vor, müssen wir diese Änderung in hunderten von Buchungszeilen gleichzeitig durchführen. Vergessen wir dabei auch nur eine Zeile, ist die Änderung inkonsistent und die Datenbank widersprüchlich.
* **Löschanomalie:**
  * *Beispiel:* Ein Kurs wird mangels Teilnehmern abgesagt, und wir löschen den dazugehörigen Termin. Wenn alle Daten in einer Zeile stehen, löschen wir mit dem Termin ungewollt auch die Stammdaten des Kurses selbst sowie die Daten der zugeordneten Lehrkraft komplett aus der Datenbank.