#!/usr/bin/env python3
"""Optimize and validate markdown documentation structure.

This tool provides two modes:
- --write: apply safe, deterministic formatting optimizations
- --check: verify that files are normalized and structurally consistent
"""

from __future__ import annotations

import argparse
import pathlib
import re
from dataclasses import dataclass


TARGET_GLOBS = (
    "docs/handbuch/**/*.md",
    "generated/klassenarbeiten/*.md",
)

STEP_RE = re.compile(r"^(### Schritt )(\d+)([a-z]?)(\b.*)$")
HEADING_RE = re.compile(r"^(#{2,4})\s+(.+?)\s*$")


@dataclass
class FileCheckResult:
    path: pathlib.Path
    changed: bool
    duplicate_headings: list[str]


def collect_files(repo_root: pathlib.Path) -> list[pathlib.Path]:
    files: list[pathlib.Path] = []
    for pattern in TARGET_GLOBS:
        files.extend(repo_root.glob(pattern))
    return sorted(set(files))


def normalize_text(text: str) -> str:
    text = text.replace("\r\n", "\n")
    lines = [line.rstrip() for line in text.split("\n")]
    lines = renumber_step_headings(lines)
    normalized = "\n".join(lines)
    normalized = re.sub(r"\n{3,}", "\n\n", normalized)
    normalized = normalized.rstrip("\n") + "\n"
    return normalized


def renumber_step_headings(lines: list[str]) -> list[str]:
    result: list[str] = []
    current_step = 0
    for line in lines:
        match = STEP_RE.match(line)
        if not match:
            result.append(line)
            continue

        prefix, _num, suffix, rest = match.groups()
        if suffix:
            if current_step == 0:
                current_step = 1
            new_num = current_step
        else:
            current_step += 1
            new_num = current_step

        result.append(f"{prefix}{new_num}{suffix}{rest}")
    return result


def find_duplicate_headings(text: str) -> list[str]:
    in_fence = False
    previous_key: str | None = None
    duplicates: list[str] = []
    for line in text.splitlines():
        if line.strip().startswith("```"):
            in_fence = not in_fence
            continue
        if in_fence:
            continue

        match = HEADING_RE.match(line)
        if not match:
            previous_key = None
            continue
        hashes, title = match.groups()
        key = f"{len(hashes)}::{title.strip().lower()}"
        if key == previous_key:
            duplicates.append(line.strip())
        previous_key = key
    return duplicates


def process_file(path: pathlib.Path, write: bool) -> FileCheckResult:
    original = path.read_text(encoding="utf-8")
    normalized = normalize_text(original)
    changed = normalized != original
    if write and changed:
        path.write_text(normalized, encoding="utf-8")

    duplicate_headings = find_duplicate_headings(normalized)
    return FileCheckResult(path=path, changed=changed, duplicate_headings=duplicate_headings)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Optimize and validate markdown documentation.")
    parser.add_argument("--check", action="store_true", help="Check only, do not modify files")
    parser.add_argument("--write", action="store_true", help="Apply optimizations to files")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    write = args.write and not args.check

    repo_root = pathlib.Path(".").resolve()
    files = collect_files(repo_root)
    if not files:
        print("[docs-opt] INFO: no markdown files matched")
        return 0

    any_changed = False
    any_duplicates = False
    for path in files:
        result = process_file(path, write=write)
        rel = path.relative_to(repo_root)
        if result.changed:
            any_changed = True
            prefix = "FIX" if write else "NEEDS-FIX"
            print(f"[docs-opt] {prefix}: {rel}")
        for heading in result.duplicate_headings:
            any_duplicates = True
            print(f"[docs-opt] DUPLICATE-HEADING: {rel}: {heading}")

    if any_duplicates:
        print("[docs-opt] FAIL: duplicate headings detected")
        return 1

    if args.check and any_changed:
        print("[docs-opt] FAIL: documentation is not normalized")
        print("[docs-opt] HINT: run 'bash scripts/optimize-docs.sh'")
        return 1

    print("[docs-opt] OK")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
