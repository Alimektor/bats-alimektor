# @file "date.bash"
# @brief Date functions.
# @description Date functions.

# @description Skip until a date. If the date is in the past, fail the test.
#
# @example
#   skip_until_date "2025-01-01"
#
# @arg $1 string date to skip until.
#
skip_until_date() {
    local check_date="${1}"
    check_date=$(date --date="${check_date}" +%Y-%m-%d)
    today=$(date +%Y-%m-%d)
    readonly today
    report "Today: ${today}."
    report "Check Date: ${check_date}."
    if (("${today//-/}" < "${check_date//-/}")) >/dev/null; then
        skip "Currently skip until ${check_date}."
    else
        fail "It's time to check this test! Check date: ${check_date}."
    fi
}
