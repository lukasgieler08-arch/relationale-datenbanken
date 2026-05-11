#!/usr/bin/env python3
"""
Konvertiert Muster-Klassenarbeit von Markdown zu verschiedenen Formaten.
Erstellt auch Validierungen und Metadaten.
"""

import markdown
from pathlib import Path

def markdown_to_html(md_file, html_file):
    """Konvertiert Markdown zu HTML"""
    with open(md_file, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    html_content = markdown.markdown(md_content, extensions=['tables', 'extra'])
    
    # Wrap mit HTML-Template (A4-druckoptimiert)
    full_html = f"""<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Muster-Klassenarbeit: Relationale Datenbanken</title>
    <style>
        @page {{
            size: A4 portrait;
            margin: 12mm;
        }}
        html, body {{
            padding: 0;
        }}
        body {{
            font-family: 'Calibri', 'Arial', sans-serif;
            line-height: 1.45;
            margin: 0 auto;
            max-width: 186mm;
            color: #222;
            font-size: 11pt;
        }}
        h1, h2, h3, h4 {{
            color: #1a5f8f;
            margin-top: 1em;
            margin-bottom: 0.5em;
            page-break-after: avoid;
        }}
        h1 {{ font-size: 20pt; border-bottom: 3px solid #1a5f8f; padding-bottom: 0.35em; }}
        h2 {{ font-size: 15pt; }}
        h3 {{ font-size: 12.5pt; }}
        p, li {{
            orphans: 3;
            widows: 3;
        }}
        table {{
            border-collapse: collapse;
            width: 100%;
            margin: 1em 0;
            page-break-inside: avoid;
        }}
        table th, table td {{
            border: 1px solid #ddd;
            padding: 0.4em 0.45em;
            text-align: left;
            vertical-align: top;
            font-size: 10.5pt;
        }}
        table th {{
            background-color: #e8f1f7;
            font-weight: bold;
        }}
        pre {{
            background-color: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 1em;
            overflow-x: auto;
            font-family: 'Courier New', monospace;
        }}
        code {{
            background-color: #f5f5f5;
            padding: 2px 4px;
            border-radius: 2px;
            font-family: 'Courier New', monospace;
        }}
        .box {{
            border-left: 4px solid #1a5f8f;
            padding: 1em;
            margin: 1em 0;
            background-color: #f0f5fa;
        }}
        .hint {{ border-left-color: #ffa500; background-color: #fffaf0; }}
        .warning {{ border-left-color: #ff6b6b; background-color: #ffe0e0; }}
        img {{
            display: block;
            max-width: 100%;
            height: auto;
            margin: 0.6em auto;
            border: 1px solid #d3dbe8;
            border-radius: 6px;
            page-break-inside: avoid;
        }}
        @media print {{
            body {{
                max-width: none;
                margin: 0;
            }}
            pre, blockquote, table, img {{
                page-break-inside: avoid;
            }}
            h2, h3 {{
                break-after: avoid-page;
            }}
        }}
    </style>
</head>
<body>
    {html_content}
</body>
</html>"""
    
    with open(html_file, 'w', encoding='utf-8') as f:
        f.write(full_html)
    
    return html_file

def validate_markdown(md_file):
    """Führt grundlegende Validierungen durch"""
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    validation = {
        "has_frontmatter": content.startswith("---"),
        "has_aufgaben": content.count("## Aufgabe") > 0,
        "table_count": content.count("|"),
        "code_block_count": content.count("```"),
        "heading_count": content.count("# "),
        "link_count": content.count("[") and content.count("]"),
    }
    
    print("✅ Markdown-Validierung:")
    for key, value in validation.items():
        status = "✓" if value else "✗"
        print(f"  {status} {key}: {value}")
    
    return validation

def extract_metadata(md_file):
    """Extrahiert Metadaten aus Frontmatter"""
    import re
    with open(md_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    frontmatter_match = re.match(r'^---\n(.*?)\n---', content, re.DOTALL)
    if frontmatter_match:
        frontmatter = frontmatter_match.group(1)
        print("\n📋 Metadaten:")
        for line in frontmatter.split('\n'):
            if line.strip():
                print(f"  {line}")
    
    # Extrahiere Aufgaben
    aufgaben = re.findall(r'## Aufgabe (\d+):(.*?)\n\n', content)
    print(f"\n📝 Aufgaben gefunden: {len(aufgaben)}")
    for num, title in aufgaben:
        print(f"  Aufgabe {num}: {title.strip()[:60]}...")

def find_ka_markdown_files(base_dir: Path) -> list[Path]:
    """Find KA markdown files following KF-ROUTINE-010 naming.

    Allowed suffixes:
    - *_aufg.md
    - *_lsg.md
    """
    files: list[Path] = []
    for md_file in sorted(base_dir.glob("KA*_*.md")):
        name = md_file.name
        if name.endswith("_aufg.md") or name.endswith("_lsg.md"):
            files.append(md_file)
    return files


def main():
    base_dir = Path("/workspaces/edu-code-course-rdb/generated/klassenarbeiten")
    md_files = find_ka_markdown_files(base_dir)

    if not md_files:
        print(f"❌ Keine KA-Markdown-Dateien gefunden in: {base_dir}")
        raise SystemExit(1)

    print(f"🔍 Gefundene KA-Markdown-Dateien: {len(md_files)}")

    generated_html: list[Path] = []
    for md_file in md_files:
        html_file = md_file.with_suffix(".html")
        print(f"\n🔄 Verarbeite: {md_file}")

        # Validierung
        validate_markdown(str(md_file))

        # Metadaten extrahieren
        extract_metadata(str(md_file))

        # Zu HTML konvertieren
        markdown_to_html(str(md_file), str(html_file))
        print(f"✅ HTML erstellt: {html_file}")
        generated_html.append(html_file)

    print("\n✨ Fertig! Dateien erstellt:")
    for html_file in generated_html:
        print(f"  - {html_file}")
    if generated_html:
        print(f"\n💡 Um zu DOCX zu konvertieren: pandoc {generated_html[0]} -o Klassenarbeit.docx")

if __name__ == "__main__":
    main()
