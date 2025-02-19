#!/usr/bin/env -S bats
# Test env.bash

bats_require_minimum_version 1.5.0

bats_load_library "bats-support"
bats_load_library "bats-assert"
bats_load_library "bats-file"
bats_load_library "bats-alimektor"

# bats file_tags=env

setup_file() {
    setup_environment
    cat <<EOF >/tmp/test.py
#!/usr/bin/env python3
print("Hello, World!")
EOF
    chmod +x /tmp/test.py
    cat <<EOF >/tmp/test.sh
#!/usr/bin/env bash
echo "Hello, World!"
EOF
    chmod +x /tmp/test.sh
    mv tests/sample/skip_if_docker.bats-sample /tmp/skip_if_docker.bats
    mv tests/sample/skip_if_not_docker.bats-sample /tmp/skip_if_not_docker.bats
    mv tests/sample/skip_if_windows.bats-sample /tmp/skip_if_windows.bats
    mv tests/sample/skip_if_not_windows.bats-sample /tmp/skip_if_not_windows.bats
    mv tests/sample/skip_if_termux.bats-sample /tmp/skip_if_termux.bats
    mv tests/sample/skip_if_not_termux.bats-sample /tmp/skip_if_not_termux.bats
    mv tests/sample/skip_if_linux.bats-sample /tmp/skip_if_linux.bats
    mv tests/sample/skip_if_not_linux.bats-sample /tmp/skip_if_not_linux.bats
    report "Test env.bash"
}

teardown_file() {
    rm -f /tmp/test.py
    rm -f /tmp/test.sh
    rm -f /tmp/skip_if_docker.bats
    rm -f /tmp/skip_if_not_docker.bats
    rm -f /tmp/skip_if_windows.bats
    rm -f /tmp/skip_if_not_windows.bats
    rm -f /tmp/skip_if_termux.bats
    rm -f /tmp/skip_if_not_termux.bats
    rm -f /tmp/skip_if_linux.bats
    rm -f /tmp/skip_if_not_linux.bats
}

@test "Check setup_environment: TERM" {
    run -0 echo "${TERM}"
    assert_output "xterm-256color"
}

@test "Check get_absolute_path: /var/" {
    cd /var
    run -0 get_absolute_path "."
    assert_output "/var"
}

@test "Check get_absolute_path: /etc/" {
    run -0 get_absolute_path "/etc/"
    assert_output "/etc"
}

@test "Check get_absolute_path: /etc/passwd" {
    cd /etc
    run -0 get_absolute_path "passwd"
    assert_output "/etc/passwd"
}

@test "Check check_shebang: /tmp/test.py" {
    run -0 check_shebang "/tmp/test.py" "python3"
    assert_output ""
}

@test "Check check_shebang: /tmp/test.sh" {
    run -0 check_shebang "/tmp/test.sh" "bash"
    assert_output ""
}

@test "Check check_shebang fail: /tmp/test.sh" {
    run -1 check_shebang "/tmp/test.sh" "python3"
    assert_output ""
}

@test "Check check_shebang fail: /tmp/test.py" {
    run -1 check_shebang "/tmp/test.py" "bash"
    assert_output ""
}

@test "Check skip_if_docker" {
    skip_if_not_docker
    run -0 /tmp/skip_if_docker.bats
    echo -e "1..1\nok 1 Skip if docker # skip Docker doesn't need it." | assert_output -
}

@test "Check skip_if_not_docker" {
    skip_if_not_docker
    run -0 /tmp/skip_if_not_docker.bats
    echo -e "1..1\nok 1 Skip if not docker" | assert_output -
}

@test "Check skip_if_not_docker in Fake Real System" {
    skip_if_not_docker
    mv "/.dockerenv" "/.dockerenv.bak"
    run -0 /tmp/skip_if_not_docker.bats
    echo -e "1..1\nok 1 Skip if not docker # skip Not a Docker system." | assert_output -
    mv "/.dockerenv.bak" "/.dockerenv"
}

@test "Check skip_if_windows" {
    skip_if_not_docker
    run -0 /tmp/skip_if_windows.bats
    echo -e "1..1\nok 1 Skip if windows" | assert_output -
}

@test "Check skip_if_not_windows" {
    skip_if_not_docker
    run -0 /tmp/skip_if_not_windows.bats
    echo -e "1..1\nok 1 Skip if not windows # skip Not a Windows system." | assert_output -
}

@test "Check skip_if_windows in Fake Windows" {
    skip_if_not_docker
    mv /bin/uname /bin/uname.bak
    echo "echo 'MINGW64_NT-10.0'" >/bin/uname
    chmod +x /bin/uname
    run -0 /tmp/skip_if_windows.bats
    echo -e "1..1\nok 1 Skip if windows # skip Windows doesn't need it." | assert_output -
    mv /bin/uname.bak /bin/uname
}

@test "Check skip_if_termux" {
    skip_if_not_docker
    run -0 /tmp/skip_if_termux.bats
    echo -e "1..1\nok 1 Skip if termux" | assert_output -
}

@test "Check skip_if_not_termux" {
    skip_if_not_docker
    run -0 /tmp/skip_if_not_termux.bats
    echo -e "1..1\nok 1 Skip if not termux # skip Not a Termux system." | assert_output -
}

@test "Check skip_if_termux in Fake Termux" {
    skip_if_not_docker
    touch /bin/termux-setup-storage
    run -0 /tmp/skip_if_termux.bats
    echo -e "1..1\nok 1 Skip if termux # skip Termux doesn't need it." | assert_output -
    rm -f /bin/termux-setup-storage
}

@test "Check skip_if_linux" {
    skip_if_not_docker
    run -0 /tmp/skip_if_linux.bats
    echo -e "1..1\nok 1 Skip if linux # skip Linux doesn't need it." | assert_output -
}

@test "Check skip_if_not_linux" {
    skip_if_not_docker
    run -0 /tmp/skip_if_not_linux.bats
    echo -e "1..1\nok 1 Skip if not linux" | assert_output -
}

@test "Check skip_if_not_linux in Fake Windows" {
    skip_if_not_docker
    mv /bin/uname /bin/uname.bak
    echo "echo 'MINGW64_NT-10.0'" >/bin/uname
    chmod +x /bin/uname
    run -0 /tmp/skip_if_not_linux.bats
    echo -e "1..1\nok 1 Skip if not linux # skip Not a Linux system." | assert_output -
    mv /bin/uname.bak /bin/uname
}
