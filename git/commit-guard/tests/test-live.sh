#!/bin/sh

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
pass=0
fail=0

new_repo() {
    dir=$(mktemp -d)
    git -C "$dir" init -q
    git -C "$dir" config user.email test@example.com
    git -C "$dir" config user.name tester
    git -C "$dir" config core.autocrlf false
    git -C "$dir" config core.hooksPath "$ROOT"
    printf '%s' "$dir"
}

expect_block() {
    output=$(git -C "$1" commit -m test 2>&1)
    rc=$?
    if [ "$rc" -ne 0 ] && printf '%s' "$output" | grep -qF "BLOCKED" && printf '%s' "$output" | grep -qF "$3"; then
        echo "PASS block: $2"
        pass=$((pass + 1))
    else
        echo "FAIL block: $2 (rc=$rc; output=[$output])"
        fail=$((fail + 1))
    fi
}

expect_allow() {
    output=$(git -C "$1" commit -m test 2>&1)
    rc=$?
    if [ "$rc" -eq 0 ]; then
        echo "PASS allow: $2"
        pass=$((pass + 1))
    else
        echo "FAIL allow: $2 (rc=$rc; output=[$output])"
        fail=$((fail + 1))
    fi
}

repo=$(new_repo)
echo "ok" > "$repo/readme.md"
git -C "$repo" add readme.md
expect_allow "$repo" "clean file"
rm -rf "$repo"

repo=$(new_repo)
echo "SECRET=1" > "$repo/.env"
git -C "$repo" add .env
expect_block "$repo" ".env" ".env"
rm -rf "$repo"

repo=$(new_repo)
echo "ignored.txt" > "$repo/.gitignore"
echo "data" > "$repo/ignored.txt"
git -C "$repo" add .gitignore
git -C "$repo" add -f ignored.txt
expect_block "$repo" "force-added ignored file" "ignored.txt"
rm -rf "$repo"

repo=$(new_repo)
mkdir -p "$repo/sub"
echo "SECRET=1" > "$repo/sub/.env.local"
git -C "$repo" add sub/.env.local
expect_block "$repo" "nested denylisted file" ".env.local"
rm -rf "$repo"

repo=$(new_repo)
echo "x" > "$repo/my secret.pem"
git -C "$repo" add "my secret.pem"
expect_block "$repo" "spaced filename" "my secret.pem"
rm -rf "$repo"

repo=$(new_repo)
echo "x" > "$repo/.env"
git -C "$repo" add .env
git -C "$repo" commit --no-verify -q -m seed
git -C "$repo" rm -q .env
expect_allow "$repo" "denylisted file deletion"
rm -rf "$repo"

echo "---"
echo "passed=$pass failed=$fail"
[ "$fail" -eq 0 ]
