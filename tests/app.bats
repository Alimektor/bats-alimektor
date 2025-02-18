#!/usr/bin/env -S bats
# Test app.bash

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=app

setup_file() {
    setup_environment
    if [[ -z "${USERPROFILE}" ]]; then
        export USERPROFILE="${HOME}"
        mkdir -p "${USERPROFILE}/AppData/Roaming/Microsoft/Windows/Start Menu/Programs"
    fi
    if [[ -z "${ALLUSERSPROFILE}" ]]; then
        export ALLUSERSPROFILE="/"
        mkdir -p "${ALLUSERSPROFILE}/Microsoft/Windows/Start Menu/Programs"
    fi
    report "Test app.bash"
}

@test "Check sample app: fastfetch" {
    run -0 check_app "fastfetch"
    assert_success
}

@test "Check sample app: python3" {
    run -0 check_app "python3"
    assert_success
}

@test "Check python app: pytest" {
    run -0 check_app "pytest" "python3"
    assert_success
}

@test "Check Windows app for all users: Firefox" {
    touch "${ALLUSERSPROFILE}/Microsoft/Windows/Start Menu/Programs/Firefox.lnk"
    run -0 check_app "Firefox" "windows-all"
    assert_success
}

@test "Check Windows app for user: Opera GX Browser" {
    touch "${USERPROFILE}/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Opera GX Browser.lnk"
    run -0 check_app "Opera GX Browser" "windows-user"
    assert_success
}
