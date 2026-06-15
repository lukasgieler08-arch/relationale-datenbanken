import json
import os
from pathlib import Path

import pymysql
from flask import Flask, jsonify, request

app = Flask(__name__)


def load_json_file(path_value: str) -> dict:
    json_path = Path(path_value)
    if not json_path.exists():
        return {"error": f"JSON-Datei nicht gefunden: {json_path}"}
    with json_path.open("r", encoding="utf-8") as f:
        return json.load(f)


def allowed_cors_origins() -> set[str]:
    configured = os.getenv("CORS_ALLOWED_ORIGINS", "http://localhost:8080,http://127.0.0.1:8080")
    return {origin.strip() for origin in configured.split(",") if origin.strip()}


@app.after_request
def add_cors_headers(response):
    origin = request.headers.get("Origin")
    if origin and origin in allowed_cors_origins():
        response.headers["Access-Control-Allow-Origin"] = origin
        response.headers["Access-Control-Allow-Methods"] = "GET, OPTIONS"
        response.headers["Access-Control-Allow-Headers"] = "Content-Type"
        response.headers["Access-Control-Max-Age"] = "600"
        response.headers["Vary"] = "Origin"
    return response


@app.before_request
def handle_cors_preflight():
    if request.method == "OPTIONS":
        return ("", 204)


def load_json_db():
    return load_json_file(os.getenv("JSON_DB_PATH", "/app/data.json"))


def load_curriculum_index():
    return load_json_file(os.getenv("CURRICULUM_INDEX_PATH", "/app/generated/lehrplaene/index.json"))


def load_curriculum_document(slug: str):
    index_data = load_curriculum_index()
    if "error" in index_data:
        return index_data

    for document in index_data.get("documents", []):
        if document.get("slug") == slug:
            document_path = Path("/app") / document["document_json"]
            curriculum_doc = load_json_file(str(document_path))
            if "error" in curriculum_doc:
                return curriculum_doc
            curriculum_doc["recommendations"] = build_recommendations(curriculum_doc.get("tag_summary", {}))
            return curriculum_doc
    return {"error": f"Lehrplan nicht gefunden: {slug}"}


def build_recommendations(tag_summary: dict):
    recommendations = []

    if tag_summary.get("eerm", 0):
        recommendations.append(
            {
                "type": "learning-path",
                "title": "EERM vom Sachverhalt ableiten",
                "summary": "Starte mit fachlichen Objekten, Kardinalitaeten und Schluesselbeziehungen und sichere die Modellierung mit einem Begruendungsschritt ab.",
            }
        )
    if tag_summary.get("normalisierung", 0) or tag_summary.get("datenintegritaet", 0):
        recommendations.append(
            {
                "type": "exercise",
                "title": "3NF begruenden",
                "summary": "Ergänze Übungen, in denen Lernende Redundanzen erkennen, funktionale Abhängigkeiten benennen und ihr Zielmodell fachlich begründen.",
            }
        )
    if tag_summary.get("sql-select", 0) or tag_summary.get("sql-join", 0) or tag_summary.get("sql-group-by", 0):
        recommendations.append(
            {
                "type": "practice",
                "title": "SQL stufenweise trainieren",
                "summary": "Baue Aufgabenketten von einfacher SELECT-Abfrage über JOIN bis zu Aggregation und fachlicher Auswertung auf.",
            }
        )
    if tag_summary.get("begruendung", 0):
        recommendations.append(
            {
                "type": "feedback",
                "title": "Begruendung explizit einfordern",
                "summary": "Selbstkontrolle und Musterloesung sollen nicht nur Syntax, sondern auch fachliche Entscheidungen und Modellkritik sichtbar machen.",
            }
        )

    return recommendations


def mysql_status():
    host = os.getenv("MYSQL_HOST", "mysql")
    port = int(os.getenv("MYSQL_PORT", "3306"))
    user = os.getenv("MYSQL_USER", "appuser")
    password = os.getenv("MYSQL_PASSWORD", "")
    database = os.getenv("MYSQL_DATABASE", "appdb")

    if not password:
        return {"ok": False, "error": "MYSQL_PASSWORD not configured"}

    conn = None
    try:
        conn = pymysql.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            database=database,
            connect_timeout=5,
        )
        with conn.cursor() as cur:
            cur.execute("SELECT COUNT(*) FROM demo_items")
            count = cur.fetchone()[0]
        return {"ok": True, "demo_items": count}
    except Exception:
        return {"ok": False, "error": "Database connection failed"}
    finally:
        if conn is not None:
            conn.close()


@app.get("/health")
def health():
    return jsonify(
        {
            "service": "python-api",
            "status": "ok",
            "mysql": mysql_status(),
            "json_loaded": "error" not in load_json_db(),
            "curriculum_loaded": "error" not in load_curriculum_index(),
        }
    )


@app.get("/json-items")
def json_items():
    return jsonify(load_json_db())


@app.get("/db-check")
def db_check():
    return jsonify(mysql_status())


@app.get("/curricula")
def curricula():
    index_data = load_curriculum_index()
    if "error" in index_data:
        return jsonify(index_data), 404

    enriched_documents = []
    for document in index_data.get("documents", []):
        enriched_document = dict(document)
        enriched_document["recommendations"] = build_recommendations(document.get("tag_summary", {}))
        enriched_documents.append(enriched_document)

    return jsonify({"documents": enriched_documents})


@app.get("/curricula/<slug>")
def curriculum_detail(slug):
    curriculum_doc = load_curriculum_document(slug)
    if "error" in curriculum_doc:
        return jsonify(curriculum_doc), 404
    return jsonify(curriculum_doc)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
