#!/bin/sh
# item 17: every aurorae theme ships the same file set, and the look-and-feel and
# common-rc sets are complete. set-equality on the file names, so adding a file to
# every theme self-adjusts but a file missing from (or extra in) one theme fails.
set -eu
cd "$(dirname "$0")/.."

fail=0
ref="" refdir="" themes=0
for d in Resources/Aurorae/Catppuccin*-*/; do
    themes=$((themes + 1))
    files=$(cd "$d" && printf '%s\n' * | sort | tr '\n' ' ')
    if [ -z "$ref" ]; then
        ref=$files
        refdir=$d
    elif [ "$files" != "$ref" ]; then
        echo "completeness: $d file set differs from $refdir" >&2
        echo "  expected: $ref" >&2
        echo "  got:      $files" >&2
        fail=1
    fi
done

n=0
for d in Resources/LookAndFeel/Catppuccin-*-Global; do
    if [ -d "$d" ]; then n=$((n + 1)); fi
done
[ "$n" -eq 4 ] || {
    echo "completeness: expected 4 LookAndFeel Global dirs, found $n" >&2
    fail=1
}

n=0
for f in Resources/Aurorae/Common/*; do
    if [ -e "$f" ]; then n=$((n + 1)); fi
done
[ "$n" -eq 4 ] || {
    echo "completeness: expected 4 Common rc files, found $n" >&2
    fail=1
}

[ "$fail" -eq 0 ] && echo "completeness: ok ($themes themes share one file set)"
exit "$fail"
