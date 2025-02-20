#!/usr/bin/env -S bats
# Test copier creation

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=creation

setup_file() {
    setup_environment
    report "Test copier creation"
    rm -rf "${BATS_TMPDIR}/copier"
}

teardown_file() {
    rm -rf "${BATS_TMPDIR}/copier"
}

@test "Check copier creation" {
    run -0 copier copy --trust . "${BATS_TMPDIR}/copier" --d name=bats_script -d description="Hello from Bats" -d file_tags=hello
    cd "${BATS_TMPDIR}/copier"
    run -0 bats .
    assert_line --index 0 "1..1"
    assert_line --index 1 '# [0mHello from Bats'
    assert_line --index 2 "ok 1 Hello from Bats"
}
