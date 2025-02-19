# @file "env.bash"
# @brief Environment functions.
# @description Environment functions.

# @description Setup the environment.
#
# @example
#   setup_environment
#
setup_environment() {
    export TERM="xterm-256color"
}

# @description Get the absolute path of a file or directory.
#
# @example
#   get_absolute_path "file.txt"
#   get_absolute_path "some_directory"
#
# @arg $1 string The file or directory to get the absolute path of.
#
# @exitcode 0 If the file or directory is found.
# @exitcode 1 If the file or directory is not found.
#
# @stdout The absolute path of the file or directory.
get_absolute_path() {
    local path="$1"

    # Check if the path exists (file or directory)
    if [[ ! -e "${path}" ]]; then
        echo "Error: Path '${path}' not found." >&2
        return 1
    fi

    # Resolve the absolute path
    local absolute_path
    absolute_path=$(realpath "${path}")

    # Output the absolute path
    echo "${absolute_path}"
    return 0
}

# @description Check the shebang of a file.
#
# @example
#   check_shebang "file.py" "python3"
#   check_shebang "file.sh" "bash"
#
# @arg $1 string The file to check the shebang of.
# @arg $2 string The interpreter to check the shebang of.
#
# @exitcode 0 If the shebang is correct.
# @exitcode 1 If the shebang is incorrect.
#
# @stdout The shebang of the file.
check_shebang() {
    local _binary="${1}"
    local _filename=""
    if command -v "${_binary}" >/dev/null 2>&1; then
        _filename="$(command -v "${_binary}")"
    fi
    if [[ -f "${_binary}" ]]; then
        _filename="$(get_absolute_path "${_binary}")"
    fi
    local _interpreter="${2}"
    local _pattern='#!/usr/bin/env.*'
    local _first_string
    _first_string="$(head -n 1 "${_filename}")"
    if echo "${_first_string}" | grep -qE "${_pattern}${_interpreter}"; then
        return 0
    else
        return 1
    fi
}

# @description Skip if the system is a Docker system.
#
# @example
#   skip_if_docker
#
skip_if_docker() {
    if [[ -f "/.dockerenv" ]]; then
        skip "Docker doesn't need it."
    fi
}

# @description Skip if the system is not a Docker system.
#
# @example
#   skip_if_not_docker
#
skip_if_not_docker() {
    if [[ ! -f "/.dockerenv" ]]; then
        skip "Not a Docker system."
    fi
}

# @description Skip if the system is a Termux system.
#
# @example
#   skip_if_termux
#
skip_if_termux() {
    if command -v termux-setup-storage; then
        skip "Termux doesn't need it."
    fi
}

# @description Skip if the system is not a Termux system.
#
# @example
#   skip_if_not_termux
#
skip_if_not_termux() {
    if ! command -v termux-setup-storage; then
        skip "Not a Termux system."
    fi
}

# @description Skip if the system is a Linux system.
#
# @example
#   skip_if_linux
#
skip_if_linux() {
    if [[ "$(uname -s || true)" =~ "Linux" ]]; then
        skip "Linux doesn't need it."
    fi
}

# @description Skip if the system is not a Linux system.
#
# @example
#   skip_if_not_linux
#
skip_if_not_linux() {
    if [[ ! "$(uname -s || true)" =~ "Linux" ]]; then
        skip "Not a Linux system."
    fi
}

# @description Skip if the system is a Windows system.
#
# @example
#   skip_if_windows
#
skip_if_windows() {
    if [[ ("$(uname -s || true)" =~ "MINGW") || ("$(uname -s || true)" =~ "CYGWIN") ]]; then
        skip "Windows doesn't need it."
    fi
}

# @description Skip if the system is not a Windows system.
#
# @example
#   skip_if_not_windows
#
skip_if_not_windows() {
    if ! [[ ("$(uname -s || true)" =~ "MINGW") || ("$(uname -s || true)" =~ "CYGWIN") ]]; then
        skip "Not a Windows system."
    fi
}
