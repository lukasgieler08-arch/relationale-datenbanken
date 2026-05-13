#!/usr/bin/env python3
"""Analyze native MySQL Workbench reference models.

The script reads `.mwb` archives, verifies the native Workbench archive layout,
and extracts a compact report with schema, table, FK, and index metadata.
It is intended to keep the generator aligned with real reference artifacts.
"""

from __future__ import annotations

import argparse
import pathlib
import sys
import xml.etree.ElementTree as ET
import zipfile
from dataclasses import dataclass


@dataclass(frozen=True)
class TableSummary:
    name: str
    column_count: int
    fk_count: int
    index_count: int


@dataclass(frozen=True)
class SchemaSummary:
    name: str
    charset: str
    collation: str
    tables: list[TableSummary]


@dataclass(frozen=True)
class ArchiveSummary:
    file_name: str
    entries: list[str]
    schemas: list[SchemaSummary]


def _extract_text(element: ET.Element, xpath: str, default: str = "") -> str:
    value = element.findtext(xpath)
    return value if value is not None else default


def _load_archive(path: pathlib.Path) -> ArchiveSummary:
    with zipfile.ZipFile(path) as archive:
        entries = sorted(archive.namelist())
        xml_bytes = archive.read("document.mwb.xml")

    root = ET.fromstring(xml_bytes)
    schema_nodes = root.findall('.//value[@key="schemata"]/value[@struct-name="db.mysql.Schema"]')

    schemas: list[SchemaSummary] = []
    for schema in schema_nodes:
        name = _extract_text(schema, './value[@key="name"]')
        charset = _extract_text(schema, './value[@key="defaultCharacterSetName"]')
        collation = _extract_text(schema, './value[@key="defaultCollationName"]')
        tables: list[TableSummary] = []

        table_nodes = schema.findall('./value[@key="tables"]/value[@struct-name="db.mysql.Table"]')
        for table in table_nodes:
            table_name = _extract_text(table, './value[@key="name"]')
            column_count = len(table.findall('./value[@key="columns"]/value[@struct-name="db.mysql.Column"]'))
            fk_count = len(table.findall('./value[@key="foreignKeys"]/value[@struct-name="db.mysql.ForeignKey"]'))
            index_count = len(table.findall('./value[@key="indices"]/value[@struct-name="db.mysql.Index"]'))
            tables.append(
                TableSummary(
                    name=table_name,
                    column_count=column_count,
                    fk_count=fk_count,
                    index_count=index_count,
                )
            )

        schemas.append(SchemaSummary(name=name, charset=charset, collation=collation, tables=tables))

    return ArchiveSummary(file_name=path.name, entries=entries, schemas=schemas)


def _build_markdown(report: list[ArchiveSummary]) -> str:
    lines: list[str] = []
    lines.append("# MWB Reference Analysis")
    lines.append("")
    lines.append("Ausgewertet wurden native MySQL-Workbench-Archive aus dem Referenzordner.")
    lines.append("")

    for archive in report:
        lines.append(f"## {archive.file_name}")
        lines.append("")
        lines.append("Archive-Entries:")
        for entry in archive.entries:
            lines.append(f"- {entry}")
        lines.append("")
        for schema in archive.schemas:
            lines.append(f"- Schema: {schema.name}")
            lines.append(f"  - Charset: {schema.charset or '(leer)'}")
            lines.append(f"  - Collation: {schema.collation or '(leer)'}")
            lines.append(f"  - Tabellen: {len(schema.tables)}")
            for table in schema.tables:
                lines.append(
                    f"    - {table.name}: columns={table.column_count}, fks={table.fk_count}, indices={table.index_count}"
                )
        lines.append("")

    return "\n".join(lines).rstrip() + "\n"


def main(argv: list[str]) -> int:
    parser = argparse.ArgumentParser(description="Analyze native Workbench reference models")
    parser.add_argument(
        "input_dir",
        help="Directory containing native .mwb reference archives",
    )
    parser.add_argument(
        "--output",
        default="",
        help="Optional path for a Markdown report",
    )
    args = parser.parse_args(argv)

    input_dir = pathlib.Path(args.input_dir)
    if not input_dir.is_dir():
        print(f"ERROR: directory not found: {input_dir}", file=sys.stderr)
        return 1

    archives = []
    for path in sorted(input_dir.glob("*.mwb")):
        with zipfile.ZipFile(path) as archive:
            entries = set(archive.namelist())
            if {"document.mwb.xml", "lock", "@db/data.db"} - entries:
                print(f"WARN: skipping non-native archive: {path.name}", file=sys.stderr)
                continue
        archives.append(_load_archive(path))

    if not archives:
        print("ERROR: no native .mwb archives found", file=sys.stderr)
        return 1

    markdown = _build_markdown(archives)
    if args.output:
        output_path = pathlib.Path(args.output)
        output_path.parent.mkdir(parents=True, exist_ok=True)
        output_path.write_text(markdown, encoding="utf-8")
    else:
        print(markdown)

    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
