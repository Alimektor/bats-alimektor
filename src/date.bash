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
