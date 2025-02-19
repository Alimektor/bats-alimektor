#!/usr/bin/env -S bats
# Minimal bats test

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=hello

setup_file() {
    setup_environment
    report "Hello, World"
}

@test "Hello, World" {
    run -0 echo "Hello, World"
    assert_output --partial 'Hello, World'
}
