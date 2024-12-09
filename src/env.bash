setup_environment() {
    export TERM="xterm-256color"
}

get_absolute_path() {
    local _filename="${1}"
    local _dirname
    local _basename
    local _absolute_path=""
    _dirname="$(dirname "${_filename}")"
    cd "${_dirname}" || exit 1
    _basename="$(basename "${_filename}")"
    _absolute_path="$(pwd)/${_basename}"
    echo "${_absolute_path}"
}

check_shebang() {
    local _binary="${1}"
    local _filename=""
    if command -v "${_binary}"; then
        _filename="$(command -v "${_binary}")"
    fi
    if [[ -f "${_binary}" ]]; then
        _filename="$(get_absolute_path "${_binary}")"
    fi
    realpath "${_binary}"
    local _interpreter="${2}"
    local _pattern='#!/usr/bin/env.*'
    local _first_string
    _first_string="$(head -n 1 "${_filename}")"
    if echo "${_first_string}" | grep -E "${_pattern}${_interpreter}"; then
        return 0
    else
        return 1
    fi
}

skip_docker() {
    if [[ -f "/.dockerenv" ]]; then
        skip "Docker doesn't need it."
    fi
}

skip_not_docker() {
    if [[ ! -f "/.dockerenv" ]]; then
        skip "Not a Docker system."
    fi
}

skip_termux() {
    if command -v termux-setup-storage; then
        skip "Termux doesn't need it."
    fi
}

skip_not_termux() {
    if ! command -v termux-setup-storage; then
        skip "Not a Termux system."
    fi
}

skip_linux() {
    if [[ "$(uname -s || true)" =~ "Linux" ]]; then
        skip "Linux doesn't need it."
    fi
}

skip_not_linux() {
    if [[ ! "$(uname -s || true)" =~ "Linux" ]]; then
        skip "Not a Linux system."
    fi
}

skip_windows() {
    if [[ ("$(uname -s || true)" =~ "MINGW") || ("$(uname -s || true)" =~ "CYGWIN") ]]; then
        skip "Windows doesn't need it."
    fi
}

skip_not_windows() {
    if ! [[ ("$(uname -s || true)" =~ "MINGW") || ("$(uname -s || true)" =~ "CYGWIN") ]]; then
        skip "Not a Windows system."
    fi
}
