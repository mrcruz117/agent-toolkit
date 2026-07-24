#!/bin/sh

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
HOOK="$ROOT/pre-commit"
pass=0
fail=0

mk_repo() {
    dir=$(mktemp -d)
    git -C "$dir" init -q
    git -C "$dir" config core.autocrlf false
    printf '%s' "$dir"
}

run_hook() {
    HOOK_ERR=$(cd "$1" && sh "$HOOK" 2>&1 1>/dev/null)
    HOOK_RC=$?
}

check() {
    ok=1
    [ "$HOOK_RC" -eq "$2" ] || ok=0
    if [ -n "$3" ]; then
        printf '%s' "$HOOK_ERR" | grep -qF "$3" || ok=0
    fi
    if [ "$ok" -eq 1 ]; then
        echo "PASS: $1"
        pass=$((pass + 1))
    else
        echo "FAIL: $1 (rc=$HOOK_RC want=$2; stderr=[$HOOK_ERR])"
        fail=$((fail + 1))
    fi
}

repo=$(mk_repo)
echo "hi" > "$repo/readme.md"
git -C "$repo" add readme.md
run_hook "$repo"
check "clean file allowed" 0 ""
rm -rf "$repo"

repo=$(mk_repo)
echo "SECRET=1" > "$repo/.env"
git -C "$repo" add .env
run_hook "$repo"
check "denylisted .env blocked" 1 ".env"
rm -rf "$repo"

repo=$(mk_repo)
echo "secret.txt" > "$repo/.gitignore"
echo "data" > "$repo/secret.txt"
git -C "$repo" add .gitignore
git -C "$repo" add -f secret.txt
run_hook "$repo"
check "force-added gitignored file blocked" 1 "secret.txt"
rm -rf "$repo"

repo=$(mk_repo)
mkdir -p "$repo/.playwright-mcp"
echo "x" > "$repo/.playwright-mcp/trace.zip"
git -C "$repo" add -f .playwright-mcp/trace.zip
run_hook "$repo"
check "denylisted folder file blocked" 1 ".playwright-mcp"
rm -rf "$repo"

echo "---"
echo "passed=$pass failed=$fail"
[ "$fail" -eq 0 ]
