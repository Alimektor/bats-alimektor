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
    *)
        _check_command="command -v ${_program}"
        ;;
    esac

    if ! eval "${_check_command}"; then
        fail -e "Program ${_program} is not installed! Check by this command:\n${_check_command}"
    fi
}

check_windows_all_app() {
    local _program="${1}"
    stat "${ALLUSERSPROFILE}\Microsoft\Windows\Start Menu\Programs\\${_program}.lnk"
}

check_windows_user_app() {
    local _program="${1}"
    stat "${USERPROFILE}\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\\${_program}.lnk"
}
