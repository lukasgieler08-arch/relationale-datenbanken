<?php
$mysqlHost = getenv('MYSQL_HOST') ?: 'mysql';
$mysqlPort = getenv('MYSQL_PORT') ?: '3306';
$mysqlDb = getenv('MYSQL_DATABASE') ?: 'appdb';
$mysqlUser = getenv('MYSQL_USER') ?: 'appuser';
$mysqlPass = getenv('MYSQL_PASSWORD') ?: 'apppassword';
$pythonApiUrl = getenv('PYTHON_API_URL') ?: 'http://localhost:8000';
$curriculumPath = '/uploads/lehrplaene/BG2-AG-EG-SG-WG_Informatik_18_3992k_NEU_Abitur2021.pdf';

$learningPaths = [
  [
    'title' => 'Lernpfad 1: Von Anforderungen zum Datenmodell',
    'focus' => 'EERM, Kardinalitaeten, Schluessel und fachliche Begruendung',
    'steps' => [
      'Kontext lesen und fachliche Objekte markieren',
      'Entitaeten, Attribute und Beziehungen als EERM entwerfen',
      'Primaer- und Fremdschluessel fachlich begruenden',
      'Das Modell gegen Redundanzen und Mehrdeutigkeiten pruefen',
    ],
  ],
  [
    'title' => 'Lernpfad 2: Zur 3. Normalform und SQL-Abfragen',
    'focus' => '3NF, Datenkonsistenz, SELECT, JOIN, GROUP BY, Unterabfragen',
    'steps' => [
      'Tabellen in 1NF, 2NF und 3NF ueberfuehren',
      'Begruendete Tabellenstruktur in MySQL anlegen',
      'Abfragen schrittweise von einfach nach komplex entwickeln',
      'Ergebnisse mit Testdaten und fachlichen Erwartungen abgleichen',
    ],
  ],
];

$practiceCards = [
  [
    'title' => 'Praxisfall Coworking-Campus',
    'goal' => 'Ein EERM fuer Raumbuchungen, Tarife und Buchungsfenster entwickeln.',
    'selfCheck' => 'Sind Mehrfachbuchungen technisch ausgeschlossen und alle Beziehungen fachlich begruendet?',
    'hint' => 'Pruefe, ob Tarifdetails wirklich an die Buchung oder an einen Tarifkatalog gehoeren.',
  ],
  [
    'title' => 'Praxisfall Lernlabor',
    'goal' => 'Eine 3NF-Struktur fuer Kurse, Lehrkraefte, Räume und Materialausgaben entwerfen.',
    'selfCheck' => 'Haengen alle Nichtschluesselattribute voll funktional vom Schluessel ab?',
    'hint' => 'Achte auf transitive Abhaengigkeiten bei Raum- und Materialinformationen.',
  ],
  [
    'title' => 'Praxisfall Foodtruck-Netz',
    'goal' => 'SQL-Abfragen fuer Umsatz, Standorte und Zutatenbedarf begruendet formulieren.',
    'selfCheck' => 'Liefert deine Abfrage wirklich nur die benoetigten Tupel und vermeidet sie Doppelzaehlungen?',
    'hint' => 'Teste JOINs zuerst mit wenigen Tabellen und kontrolliere Zwischenergebnisse.',
  ],
];

$interactiveExercises = [
  [
    'id' => 'sql-join',
    'title' => 'SQL-Training: Buchungen pro Raum',
    'prompt' => 'Formuliere eine SQL-Abfrage, die fuer jeden Raum die Anzahl seiner Buchungen ausgibt. Nutze JOIN und GROUP BY.',
    'placeholder' => "SELECT r.raumname, COUNT(*) AS anzahl\nFROM raum r\nJOIN buchung b ON ...\nGROUP BY r.raumname;",
    'checks' => ['SELECT', 'JOIN', 'GROUP BY'],
  ],
  [
    'id' => 'normalform',
    'title' => 'Begruendung: Warum 3. Normalform?',
    'prompt' => 'Erklaere in 2-4 Saetzen, welche Redundanz oder transitive Abhaengigkeit du in deinem Modell beseitigt hast.',
    'placeholder' => "Die Tabelle ... wurde aufgeteilt, weil ...",
    'checks' => ['3NF', 'Abhaengigkeit', 'Redundanz'],
  ],
];

$mysqlMessage = 'Nicht getestet';

try {
    $mysqli = @new mysqli($mysqlHost, $mysqlUser, $mysqlPass, $mysqlDb, (int)$mysqlPort);
    if ($mysqli->connect_error) {
        $mysqlMessage = 'Fehler: ' . $mysqli->connect_error;
    } else {
        $result = $mysqli->query('SELECT COUNT(*) AS cnt FROM demo_items');
        $row = $result ? $result->fetch_assoc() : ['cnt' => 'n/a'];
        $mysqlMessage = 'OK, demo_items=' . $row['cnt'];
        $mysqli->close();
    }
} catch (Throwable $e) {
    $mysqlMessage = 'Exception: ' . $e->getMessage();
}
?>
<!doctype html>
<html lang="de">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>edu-code Live-Test Dashboard</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <div class="app-shell">
      <header class="app-header">
        <div class="logo-strip" aria-hidden="true"></div>
        <div class="brand-area">
          <div class="brand-copy">
            <p class="eyebrow">Relationale Datenbanken</p>
            <h1>Lernpfade, Live-Test und Selbstkontrolle</h1>
            <p class="hero-text">Die Webapp verbindet curriculare Vorgaben, technische Laufzeitpruefung und didaktisch aufbereitete Uebungsimpulse fuer EERM, 3. Normalform und SQL.</p>
          </div>
        </div>

        <div class="header-actions">
          <button class="nav-toggle" type="button" aria-expanded="false" aria-controls="primaryNav">Menü</button>
          <a class="hero-link" href="<?php echo htmlspecialchars($curriculumPath, ENT_QUOTES, 'UTF-8'); ?>" target="_blank" rel="noopener">Lehrplan oeffnen</a>
        </div>

        <nav id="primaryNav" class="primary-nav" aria-label="Hauptnavigation">
          <a href="#curriculum-section">Lehrplan</a>
          <a href="#learning-paths-section">Lernpfade</a>
          <a href="#exercise-section">Uebungen</a>
          <a href="#tech-section">Live-Test</a>
        </nav>
      </header>

      <main class="container">
        <div class="content-layout">
          <aside class="course-nav" aria-label="Kursnavigation">
            <h2>Kursnavigation</h2>
            <ul>
              <li><a href="#learning-paths-section">Lernpfade</a></li>
              <li><a href="#exercise-section">Uebungsbereich</a></li>
              <li><a href="#curriculum-section">Lehrplananalyse</a></li>
              <li><a href="#tech-section">Technik-Checks</a></li>
            </ul>
            <h3>Didaktische Linie</h3>
            <p>Verstehen → Modellieren → Normalisieren → SQL anwenden → reflektieren.</p>
          </aside>

          <div class="content-column">
      <section class="card grid two-col intro-section">
        <div>
          <h2>Didaktischer Fokus</h2>
          <p>Die Lernpfade folgen einem selbstgesteuerten Aufbau: verstehen, modellieren, pruefen, verbessern. Alle Aufgaben bleiben beim Fachthema relationale Datenbanken und verknuepfen Modellierung mit fachlich begruendeten SQL-Loesungen.</p>
        </div>
        <div>
          <h2>Ad-hoc verfuegbare Hilfen</h2>
          <ul class="check-list">
            <li>Lehrplan als verbindliche Referenz</li>
            <li>Direkte Live-Checks fuer PHP, MySQL und Python-API</li>
            <li>Aufgaben mit Selbstkontrolle, Tipps und Loesungshinweisen</li>
          </ul>
        </div>
      </section>

      <section class="section-block" id="learning-paths-section">
        <div class="section-head">
          <p class="eyebrow">Lernpfade</p>
          <h2>Selbstgesteuert vom Kontext zur Loesung</h2>
        </div>
        <div class="path-grid">
          <?php foreach ($learningPaths as $path): ?>
            <article class="card path-card">
              <h3><?php echo htmlspecialchars($path['title'], ENT_QUOTES, 'UTF-8'); ?></h3>
              <p class="muted"><?php echo htmlspecialchars($path['focus'], ENT_QUOTES, 'UTF-8'); ?></p>
              <ol>
                <?php foreach ($path['steps'] as $step): ?>
                  <li><?php echo htmlspecialchars($step, ENT_QUOTES, 'UTF-8'); ?></li>
                <?php endforeach; ?>
              </ol>
            </article>
          <?php endforeach; ?>
        </div>
      </section>

      <section class="card status-card" id="tech-section">
        <h2>PHP -> MySQL</h2>
        <p id="phpMysqlStatus"><?php echo htmlspecialchars($mysqlMessage, ENT_QUOTES, 'UTF-8'); ?></p>
      </section>

      <section class="card status-card">
        <h2>JavaScript -> Python-API</h2>
        <button id="refreshBtn">Status laden</button>
        <pre id="apiOutput">Noch kein API-Call ausgefuehrt.</pre>
      </section>

      <section class="section-block" id="curriculum-section">
        <div class="section-head">
          <p class="eyebrow">Lehrplananalyse</p>
          <h2>Automatisch abgeleitete Schwerpunkte</h2>
        </div>
        <div id="curriculumCards" class="practice-grid">
          <article class="card">
            <h3>Analyse wird geladen</h3>
            <p>Die Webapp liest die erzeugten Curricula-Artefakte ueber die Python-API ein.</p>
          </article>
        </div>
      </section>

      <section class="section-block" id="exercise-section">
        <div class="section-head">
          <p class="eyebrow">Uebungsbereich</p>
          <h2>Praxisnahe Sachverhalte mit Selbstkontrolle</h2>
        </div>
        <div class="practice-grid">
          <?php foreach ($practiceCards as $card): ?>
            <article class="card practice-card">
              <h3><?php echo htmlspecialchars($card['title'], ENT_QUOTES, 'UTF-8'); ?></h3>
              <p><?php echo htmlspecialchars($card['goal'], ENT_QUOTES, 'UTF-8'); ?></p>
              <div class="info-box">
                <strong>Selbstkontrolle</strong>
                <p><?php echo htmlspecialchars($card['selfCheck'], ENT_QUOTES, 'UTF-8'); ?></p>
              </div>
              <details>
                <summary>Tipps und Loesungshinweise</summary>
                <p><?php echo htmlspecialchars($card['hint'], ENT_QUOTES, 'UTF-8'); ?></p>
              </details>
            </article>
          <?php endforeach; ?>
        </div>
      </section>

      <section class="section-block">
        <div class="section-head">
          <p class="eyebrow">Code-Inboxen</p>
          <h2>Direkte Selbstkontrolle mit konstruktivem Feedback</h2>
        </div>
        <div class="practice-grid">
          <?php foreach ($interactiveExercises as $exercise): ?>
            <article class="card exercise-card" data-exercise-id="<?php echo htmlspecialchars($exercise['id'], ENT_QUOTES, 'UTF-8'); ?>" data-checks="<?php echo htmlspecialchars(implode('|', $exercise['checks']), ENT_QUOTES, 'UTF-8'); ?>">
              <h3><?php echo htmlspecialchars($exercise['title'], ENT_QUOTES, 'UTF-8'); ?></h3>
              <p><?php echo htmlspecialchars($exercise['prompt'], ENT_QUOTES, 'UTF-8'); ?></p>
              <textarea class="exercise-input" rows="8" placeholder="<?php echo htmlspecialchars($exercise['placeholder'], ENT_QUOTES, 'UTF-8'); ?>"></textarea>
              <div class="exercise-actions">
                <button class="exercise-check" type="button">Antwort prüfen</button>
              </div>
              <div class="info-box feedback-box" aria-live="polite">
                <strong>Feedback</strong>
                <p>Schreibe deine Lösung und prüfe sie direkt. Das Feedback weist auf fehlende Bausteine hin und gibt passende Hinweise.</p>
              </div>
            </article>
          <?php endforeach; ?>
        </div>
      </section>

      <section class="card info-strip">
        <h2>Naechster Ausbauschritt</h2>
        <p>Neue Lehrplaene werden kuenftig im Verzeichnis <strong>uploads/lehrplaene</strong> verortet. Darauf aufbauend koennen Analyse- und Generierungsprozesse curriculare Anforderungen gezielt auf Lernpfade, Aufgabenformate, Hilfsmittel und Musterloesungen fuer relationale Datenbanken abbilden.</p>
      </section>
          </div>
        </div>
      </main>
    </div>

    <script>
      window.PYTHON_API_URL = <?php echo json_encode($pythonApiUrl, JSON_UNESCAPED_SLASHES); ?>;
    </script>
    <script src="app.js"></script>
  </body>
</html>
