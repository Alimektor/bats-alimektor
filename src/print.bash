# @file "print.bash"
# @brief Print functions.
# @description Print functions.

# @description Print a message.
#
# @example
#   report "Hello, world!"
#
report() {
    local _message="${1}"
    echo -e "# \e[0m${_message}" >&3
}
