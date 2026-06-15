#!/usr/bin/env python3
"""Embed EERM PNG references into generated Klassenarbeit markdown files.

The script scans KA markdown files (naming convention KF-ROUTINE-010:
*_aufg.md and *_lsg.md) and injects a PNG image reference when missing.
The PNG filename is read from the YAML frontmatter field 'sql_db_eerm_grafik'.
"""

from __future__ import annotations

import argparse
import pathlib
import re
from dataclasses import dataclass


# KF-ROUTINE-010: KA documents follow {KAxx}_{klasse}_{year}_{year}_{version}_{aufg|lsg}.md
KA_PATTERN = re.compile(r"^KA\d+_.+_(aufg|lsg)\.md$")
FRONTMATTER_PNG_RE = re.compile(r"^\s*sql_db_eerm_grafik:\s*['\"]?(?P<png>[^'\"\n]+)['\"]?\s*$", re.MULTILINE)


@dataclass(frozen=True)
class EmbedTarget:
    markdown_file: pathlib.Path
    png_file: pathlib.Path
    prefix: str  # kept for compatibility


class MarkdownEermEmbedder:
    """Injects a standard image block for EERM PNG references (KF-ROUTINE-010)."""

    _image_regex = re.compile(r"!\[[^\]]*SQL-Kontext[^\]]*\]\([^\)]*\.png\)")

    def __init__(self, markdown_dir: pathlib.Path, dry_run: bool = False) -> None:
        self._markdown_dir = markdown_dir
        self._dry_run = dry_run

    def run(self) -> int:
        if not self._markdown_dir.exists():
            print(f"ERROR directory not found: {self._markdown_dir}")
            return 2

        changes = 0
        for md in sorted(self._markdown_dir.glob("*.md")):
            target = self._resolve_target(md)
            if target is None:
                continue
            result = self._process_one(target)
            print(result)
            if result.startswith("OK"):
                changes += 1

        print(f"SUMMARY embedded references: {changes}")
        return 0

    def _resolve_target(self, markdown_file: pathlib.Path) -> EmbedTarget | None:
        # Only process KA documents following KF-ROUTINE-010 naming convention.
        if not KA_PATTERN.match(markdown_file.name):
            return None
        text = markdown_file.read_text(encoding="utf-8", errors="replace")
        m = FRONTMATTER_PNG_RE.search(text)
        if not m:
            return None
        png_name = m.group("png").strip()
        png_file = markdown_file.parent / png_name
        return EmbedTarget(markdown_file=markdown_file, png_file=png_file, prefix=markdown_file.stem)

    def _process_one(self, target: EmbedTarget) -> str:
        text = target.markdown_file.read_text(encoding="utf-8")

        if self._image_regex.search(text):
            return f"SKIP {target.markdown_file} (image reference already present)"

        if not target.png_file.exists():
            return f"SKIP {target.markdown_file} (missing png: {target.png_file.name})"

        block = (
            "\n## Modellgrafik Teil C\n\n"
            f"![EERM Teil C - separater SQL-Kontext](./{target.png_file.name})\n"
        )

        insert_anchor = "Arbeitsgrundlage:"
        insert_pos = text.find(insert_anchor)
        if insert_pos != -1:
            # Insert after the working-material section block for better readability.
            next_heading = text.find("\n## ", insert_pos + len(insert_anchor))
            if next_heading == -1:
                next_heading = len(text)
            new_text = text[:next_heading].rstrip() + "\n" + block + text[next_heading:]
        else:
            new_text = text.rstrip() + block + "\n"

        if not self._dry_run:
            target.markdown_file.write_text(new_text, encoding="utf-8")

        return f"OK   {target.markdown_file} -> {target.png_file.name}"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Embed SQLDB EERM PNG references into generated markdown files."
    )
    parser.add_argument(
        "--markdown-dir",
        type=pathlib.Path,
        default=pathlib.Path("generated/klassenarbeiten"),
        help="Directory containing generated markdown files",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Only print planned changes without writing files",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    embedder = MarkdownEermEmbedder(markdown_dir=args.markdown_dir, dry_run=args.dry_run)
    return embedder.run()


if __name__ == "__main__":
    raise SystemExit(main())
