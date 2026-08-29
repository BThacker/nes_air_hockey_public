#!/usr/bin/env bash
# Format NESFab source files using this repository's whitespace conventions.
set -euo pipefail

usage() {
    echo "Usage: bash scripts/format_fab.sh [--check|--write]"
    echo "  --check  Report formatting differences without modifying files (default)."
    echo "  --write  Apply formatting after validating every generated file."
}

mode="check"
if [[ $# -gt 1 ]]; then
    usage >&2
    exit 2
fi
if [[ $# -eq 1 ]]; then
    case "$1" in
        --check) ;;
        --write) mode="write" ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            usage >&2
            exit 2
            ;;
    esac
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

format_dir="$(mktemp -d "${TMPDIR:-/tmp}/air_hockey_format.XXXXXX")"
trap 'rm -rf "$format_dir"' EXIT

format_file() {
    local source_file="$1"
    local formatted_file="$2"

    awk '
        { lines[++count] = $0 }
        END {
            for (i = 1; i <= count; i++) {
                if (lines[i] == "") {
                    previous_line = i - 1
                    next_line = i + 1
                    while (previous_line > 0 && lines[previous_line] == "") previous_line--
                    while (next_line <= count && lines[next_line] == "") next_line++

                    if (previous_line == 0 || next_line > count) continue
                    if (lines[previous_line] ~ /^\/\/ =+$/) continue
                    if (!last_blank) print ""
                    last_blank = 1
                    continue
                }

                if (lines[i] ~ /^(fn |nmi |mode |vars |struct )/ && output_count > 0 && !last_blank && previous !~ /^\/\//) print ""

                print lines[i]
                previous = lines[i]
                output_count++
                last_blank = 0
            }
        }
    ' "$source_file" > "$formatted_file"
}

shopt -s nullglob
source_files=(src/*.fab)
if [[ ${#source_files[@]} -eq 0 ]]; then
    echo "No NESFab source files found under src/." >&2
    exit 1
fi

changed_files=()
for source_file in "${source_files[@]}"; do
    formatted_file="$format_dir/${source_file#src/}"
    format_file "$source_file" "$formatted_file"

    if [[ -s "$source_file" && ! -s "$formatted_file" ]]; then
        echo "Refusing to replace $source_file with empty formatter output." >&2
        exit 1
    fi

    if ! cmp -s "$source_file" "$formatted_file"; then
        changed_files+=("$source_file")
        diff -u --label "$source_file" --label "$source_file" "$source_file" "$formatted_file" || true
    fi
done

if [[ ${#changed_files[@]} -eq 0 ]]; then
    echo "NESFab formatting is already up to date."
    exit 0
fi

if [[ "$mode" == "check" ]]; then
    echo "Run 'bash scripts/format_fab.sh --write' to apply formatting." >&2
    exit 1
fi

for source_file in "${changed_files[@]}"; do
    cp "$format_dir/${source_file#src/}" "$source_file"
done

echo "Formatted ${#changed_files[@]} NESFab source file(s)."
