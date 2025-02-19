# @file "app.bash"
# @brief Application functions.
# @description Application functions.

# @description Check if a program is installed.
#
# @example
#   check_app "fastfetch"
#   check_app "pytest" "python3"
#   check_app "Firefox" "windows-all"
#   check_app "Opera GX Browser" "windows-user"
#
# @arg $1 string The program to check
# @arg $2 string The type of program to check (python3, windows-all, windows-user, command)
#
# @exitcode 0 If the program is installed.
# @exitcode 1 If the program is not installed.
check_app() {
    local _program="${1}"
    local _program_type="${2}"
    local _check_command=""
    case "${_program_type}" in
    "python3")
        _check_command="python3 -c 'import ${_program}'"
        if [[ ("$(uname -s || true)" =~ "MINGW") ]]; then
            _check_command="py -c 'import ${_program}'"
        fi
        ;;
    "windows-all")
        _check_command="stat '${ALLUSERSPROFILE}/Microsoft/Windows/Start Menu/Programs/${_program}.lnk'"
        ;;
    "windows-user")
        _check_command="stat '${USERPROFILE}/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/${_program}.lnk'"
        ;;
    *)
        _check_command="command -v ${_program}"
        ;;
    esac

    if ! eval "${_check_command}"; then
        fail -e "Program ${_program} is not installed! Check by this command:\n${_check_command}"
    fi
}
