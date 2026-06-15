CREATE TABLE IF NOT EXISTS demo_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO demo_items (title)
VALUES ('Erster Eintrag'), ('Zweiter Eintrag'), ('Dritter Eintrag');
