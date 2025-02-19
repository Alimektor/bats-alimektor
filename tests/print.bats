#!/usr/bin/env -S bats
# Test print.bash

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=print

setup_file() {
    mv tests/sample/check_print.bats-sample "${BATS_TMPDIR}/check_print.bats"
    report "Test print.bash"
}

teardown_file() {
    rm -f "${BATS_TMPDIR}/check_print.bats"
}

@test "Check print message" {
    run -0 "${BATS_TMPDIR}/check_print.bats"
    echo -e "1..1\n# Check print message\nok 1 Check print message" | assert_output
}
