#!/usr/bin/env bash
#
# Test script for keep-branches tool

set -euo pipefail

BINARY="$(pwd)/.bin/keep-branches"

setup() {
    REPO_DIR=$(mktemp -d)
    cd "$REPO_DIR"
    git init -b main
    git config user.email "test@test.com"
    git config user.name "Test User"

    echo "initial" > file.txt
    git add file.txt
    git commit -m "initial commit"

    git checkout -b feature-a
    echo "feature-a" >> file.txt
    git add file.txt
    git commit -m "feature a"

    git checkout -b feature-b
    echo "feature-b" >> file.txt
    git add file.txt
    git commit -m "feature b"

    git checkout -b feature-c
    echo "feature-c" >> file.txt
    git add file.txt
    git commit -m "feature c"

    git checkout main
}

teardown() {
    if [[ -n "$REPO_DIR" && -d "$REPO_DIR" ]]; then
        rm -rf "$REPO_DIR"
    fi
}

get_local_branches() {
    git branch --format='%(refname:short)' | sort
}

run_test() {
    echo "=== Test: keep-branches removes unlisted branches ==="
    setup

    echo "Branches before: $(get_local_branches)"

    echo "We Are At $(pwd)"
    "$BINARY" feature-a

    echo "Branches after: $(get_local_branches)"

    local remaining
    remaining=$(get_local_branches)

    if [[ "$(echo "$remaining" | tr '\n' ' ')" != "feature-a main " ]]; then
        echo "FAIL: expected 'feature-a main', got '$remaining'"
        teardown
        exit 1
    fi

    echo "PASS"
    teardown
}

run_test_keeps_specified() {
    echo "=== Test: keep-branches keeps specified branches ==="
    setup

    echo "Branches before: $(get_local_branches)"

    "$BINARY" feature-b feature-c

    echo "Branches after: $(get_local_branches)"

    local remaining
    remaining=$(get_local_branches)

    if [[ "$(echo "$remaining" | tr '\n' ' ')" != "feature-b feature-c main " ]]; then
        echo "FAIL: expected 'feature-b feature-c main', got '$remaining'"
        teardown
        exit 1
    fi

    echo "PASS"
    teardown
}

run_test_keeps_current() {
    echo "=== Test: keep-branches keeps current branch ==="
    setup

    git checkout feature-a

    "$BINARY"

    local remaining
    remaining=$(get_local_branches)

    if [[ "$(echo "$remaining" | tr '\n' ' ')" != "feature-a main " ]]; then
        echo "FAIL: expected 'feature-a main', got '$remaining'"
        teardown
        exit 1
    fi

    echo "PASS"
    teardown
}

main() {
    trap teardown EXIT

    run_test
    run_test_keeps_specified
    run_test_keeps_current

    echo "=== All tests passed ==="
}

main "$@"
