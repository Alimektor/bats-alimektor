# "app.bash"

Application functions.

## Overview

Application functions.

## Index

* [check_app](#checkapp)

### check_app

Check if a program is installed.

#### Example

```bash
check_app "fastfetch"
check_app "pytest" "python3"
check_app "Firefox" "windows-all"
check_app "Opera GX Browser" "windows-user"
```

#### Arguments

* **$1** (string): The program to check
* **$2** (string): The type of program to check (python3, windows-all, windows-user, command)

#### Exit codes

* **0**: If the program is installed.
* **1**: If the program is not installed.

