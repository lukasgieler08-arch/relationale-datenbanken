class ApiStatusLoader {
  constructor({ output, button, apiBaseUrl }) {
    this.output = output;
    this.button = button;
    this.apiBaseUrl = apiBaseUrl;
  }

  async loadStatus() {
    this.output.textContent = "Lade...";
    try {
      const [healthResp, jsonResp] = await Promise.all([
        fetch(`${this.apiBaseUrl}/health`),
        fetch(`${this.apiBaseUrl}/json-items`),
      ]);

      const health = await healthResp.json();
      const jsonData = await jsonResp.json();
      this.output.textContent = JSON.stringify({ health, jsonData }, null, 2);
    } catch (err) {
      this.output.textContent = "Fehler beim API-Aufruf: " + err.message;
    }
  }

  bind() {
    this.button.addEventListener("click", () => this.loadStatus());
    this.loadStatus();
  }
}

class CurriculumLoader {
  constructor({ container, apiBaseUrl }) {
    this.container = container;
    this.apiBaseUrl = apiBaseUrl;
  }

  renderDocuments(documents) {
    if (!documents.length) {
      this.container.innerHTML = `
        <article class="card">
          <h3>Keine Lehrplandaten vorhanden</h3>
          <p>Fuehre zuerst den Lehrplan-Import aus, damit curriculare Schwerpunkte angezeigt werden.</p>
        </article>
      `;
      return;
    }

    this.container.innerHTML = documents
      .map((document) => {
        const tags = Object.entries(document.tag_summary || {})
          .map(([tag, count]) => `<li><strong>${tag}</strong>: ${count}</li>`)
          .join("");
        const recommendations = (document.recommendations || [])
          .map(
            (item) => `
              <li>
                <strong>${item.title}</strong><br />
                <span>${item.summary}</span>
              </li>`
          )
          .join("");

        return `
          <article class="card curriculum-card">
            <h3>${document.slug}</h3>
            <p>Seiten: ${document.page_count} · Chunks: ${document.chunk_count}</p>
            <div class="info-box">
              <strong>Tag-Schwerpunkte</strong>
              <ul class="compact-list">${tags}</ul>
            </div>
            <div class="info-box curriculum-actions">
              <strong>Didaktische Ableitungen</strong>
              <ul class="compact-list">${recommendations}</ul>
            </div>
          </article>
        `;
      })
      .join("");
  }

  async load() {
    try {
      const response = await fetch(`${this.apiBaseUrl}/curricula`);
      const payload = await response.json();
      this.renderDocuments(payload.documents || []);
    } catch (err) {
      this.container.innerHTML = `
        <article class="card">
          <h3>Lehrplananalyse nicht erreichbar</h3>
          <p>Fehler beim Laden der curriculären Auswertung: ${err.message}</p>
        </article>
      `;
    }
  }
}

class ExerciseEvaluator {
  constructor(rootElement) {
    this.rootElement = rootElement;
    this.input = rootElement.querySelector(".exercise-input");
    this.button = rootElement.querySelector(".exercise-check");
    this.feedback = rootElement.querySelector(".feedback-box p");
    this.requiredTokens = (rootElement.dataset.checks || "")
      .split("|")
      .map((token) => token.trim())
      .filter(Boolean);
  }

  evaluate() {
    const answer = this.input.value.trim();
    if (!answer) {
      this.feedback.textContent =
        "Noch keine Loesung eingetragen. Beginne mit einem fachlich begruendeten ersten Entwurf und pruefe dann gezielt Schluesselwoerter oder Begruendungen.";
      return;
    }

    const normalizedAnswer = answer.toUpperCase();
    const missingTokens = this.requiredTokens.filter(
      (token) => !normalizedAnswer.includes(token.toUpperCase())
    );

    if (missingTokens.length === 0) {
      this.feedback.textContent =
        "Starke Grundlage. Die geforderten Kernbausteine sind vorhanden. Pruefe jetzt noch fachlich, ob deine JOIN-Bedingungen oder Begruendungen exakt zum Sachverhalt passen und keine unnoetigen Attribute mitschwingen.";
      return;
    }

    this.feedback.textContent = `Noch unvollstaendig: ${missingTokens.join(", ")}. Ergaenze diese Bausteine und verknuepfe sie mit einer fachlichen Begruendung. Arbeite schrittweise: erst Struktur, dann Praezision.`;
  }

  bind() {
    this.button.addEventListener("click", () => this.evaluate());
  }
}

const output = document.getElementById("apiOutput");
const btn = document.getElementById("refreshBtn");
const curriculumCards = document.getElementById("curriculumCards");
const navToggle = document.querySelector(".nav-toggle");
const primaryNav = document.getElementById("primaryNav");
const apiBaseUrl = window.PYTHON_API_URL || "http://localhost:8000";

new ApiStatusLoader({ output, button: btn, apiBaseUrl }).bind();
new CurriculumLoader({ container: curriculumCards, apiBaseUrl }).load();

if (navToggle && primaryNav) {
  navToggle.addEventListener("click", () => {
    const isOpen = primaryNav.classList.toggle("is-open");
    navToggle.setAttribute("aria-expanded", String(isOpen));
  });

  primaryNav.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", () => {
      if (window.innerWidth <= 900) {
        primaryNav.classList.remove("is-open");
        navToggle.setAttribute("aria-expanded", "false");
      }
    });
  });
}

document
  .querySelectorAll(".exercise-card")
  .forEach((card) => new ExerciseEvaluator(card).bind());
