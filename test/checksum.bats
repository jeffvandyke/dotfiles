#!/usr/bin/env bats
# Tests for bin/checksum and bin/checksum-sync.
# Run with: bats test/checksum.bats
# Install bats:  sudo pacman -S bats

PATH="$BATS_TEST_DIRNAME/../bin:$PATH"

setup() {
    TEST_DIR=$(mktemp -d)
    cd "$TEST_DIR"
    printf 'alpha\n'  > file_a.txt
    printf 'beta\n'   > file_b.txt
    mkdir -p subdir
    printf 'gamma\n'  > subdir/file_c.txt
}

teardown() {
    rm -rf "$TEST_DIR"
}

# ── checksum ──────────────────────────────────────────────────────────────────

@test "checksum: creates checksums.txt with correct hashes" {
    checksum >/dev/null
    while IFS= read -r line; do
        hash="${line:0:64}"
        path="${line:66}"
        [ "$(sha256sum "$path" | cut -c1-64)" = "$hash" ]
    done < checksums.txt
}

@test "checksum: excludes checksums.txt itself" {
    checksum >/dev/null
    run grep -F "checksums.txt" checksums.txt
    [ "$status" -ne 0 ]
}

@test "checksum: output is LC_ALL=C stable-sorted by path" {
    printf 'x\n' > Z.txt
    printf 'x\n' > a.txt
    checksum >/dev/null
    paths=$(awk '{print substr($0,67)}' checksums.txt)
    sorted=$(printf '%s\n' $paths | LC_ALL=C sort -s)
    [ "$paths" = "$sorted" ]
}

@test "checksum: does not write checksums.txt on pipeline failure" {
    touch unreadable.txt && chmod 000 unreadable.txt
    run checksum
    chmod 644 unreadable.txt
    [ "$status" -ne 0 ]
    # checksums.txt must not exist (temp file cleaned up, no partial write)
    [ ! -f checksums.txt ]
}

# ── checksum-sync ─────────────────────────────────────────────────────────────

@test "checksum-sync: does not re-hash files already in checksums.txt" {
    # Plant a wrong hash for file_a.txt — if sync re-hashes it, the hash changes
    wrong="0000000000000000000000000000000000000000000000000000000000000000"
    printf '%s  ./file_a.txt\n' "$wrong" > checksums.txt
    checksum-sync 2>/dev/null
    run grep -F "$wrong  ./file_a.txt" checksums.txt
    [ "$status" -eq 0 ]
}

@test "checksum-sync: adds new files not yet in checksums.txt" {
    checksum >/dev/null
    printf 'new\n' > new_file.txt
    checksum-sync 2>/dev/null
    expected=$(sha256sum ./new_file.txt | cut -c1-64)
    run grep -F "$expected  ./new_file.txt" checksums.txt
    [ "$status" -eq 0 ]
}

@test "checksum-sync: sort order matches checksum on same directory" {
    printf 'x\n' > Z.txt
    printf 'x\n' > a.txt
    checksum >/dev/null
    before=$(cat checksums.txt)
    checksum-sync 2>/dev/null
    [ "$(cat checksums.txt)" = "$before" ]
}

@test "checksum-sync: idempotent — two runs produce identical checksums.txt" {
    checksum >/dev/null
    checksum-sync 2>/dev/null
    first=$(cat checksums.txt)
    checksum-sync 2>/dev/null
    [ "$(cat checksums.txt)" = "$first" ]
}

@test "checksum-sync: reports missing files on stdout" {
    checksum >/dev/null
    rm file_a.txt
    run checksum-sync
    [[ "$output" == *"MISSING: ./file_a.txt"* ]]
}

@test "checksum-sync: missing files remain in checksums.txt without --rm" {
    checksum >/dev/null
    rm file_a.txt
    checksum-sync 2>/dev/null
    run grep -F "./file_a.txt" checksums.txt
    [ "$status" -eq 0 ]
}

@test "checksum-sync --rm: removes entries for missing files" {
    checksum >/dev/null
    rm file_a.txt
    checksum-sync --rm 2>/dev/null
    run grep -F "./file_a.txt" checksums.txt
    [ "$status" -ne 0 ]
}

@test "checksum-sync --rm: preserves entries for present files" {
    checksum >/dev/null
    rm file_a.txt
    checksum-sync --rm 2>/dev/null
    run grep -F "./file_b.txt" checksums.txt
    [ "$status" -eq 0 ]
}

@test "checksum-sync: handles filenames with double spaces" {
    printf 'photo\n' > "IMG  001.jpg"
    checksum >/dev/null
    checksum-sync 2>/dev/null
    # Idempotent — no false MISSING report for the double-space file
    run checksum-sync
    [[ "$output" != *"MISSING"* ]]
}

@test "checksum-sync: handles subdir paths with double spaces" {
    mkdir -p "My  Photos"
    printf 'snap\n' > "My  Photos/pic.jpg"
    checksum >/dev/null
    checksum-sync 2>/dev/null
    run grep -F "./My  Photos/pic.jpg" checksums.txt
    [ "$status" -eq 0 ]
}
