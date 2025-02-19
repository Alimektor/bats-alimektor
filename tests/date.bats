#!/usr/bin/env -S bats
# Test app.bash

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=date

setup_file() {
    setup_environment
    mv tests/sample/skip_until_date.bats-sample "${BATS_TMPDIR}/skip_until_date.bats"
    mv tests/sample/skip_after_date.bats-sample "${BATS_TMPDIR}/skip_after_date.bats"
    report "Test app.bash"
}

teardown_file() {
    rm -f "${BATS_TMPDIR}/skip_until_date.bats"
    rm -f "${BATS_TMPDIR}/skip_after_date.bats"
}

@test "Check date until 3000-01-01" {
    run -0 "${BATS_TMPDIR}/skip_until_date.bats"
    assert_output --partial "Check date until 3000-01-01 # skip Currently skip until 3000-01-01."
}

@test "Check date after 2000-01-01" {
    run -1 "${BATS_TMPDIR}/skip_after_date.bats"
    assert_output --partial "It's time to check this test! Check date: 2000-01-01."
}
