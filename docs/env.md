# "env.bash"

Environment functions.

## Overview

Environment functions.

## Index

* [setup_environment](#setupenvironment)
* [get_absolute_path](#getabsolutepath)
* [check_shebang](#checkshebang)
* [skip_if_docker](#skipifdocker)
* [skip_if_not_docker](#skipifnotdocker)
* [skip_if_termux](#skipiftermux)
* [skip_if_not_termux](#skipifnottermux)
* [skip_if_linux](#skipiflinux)
* [skip_if_not_linux](#skipifnotlinux)
* [skip_if_windows](#skipifwindows)
* [skip_if_not_windows](#skipifnotwindows)

### setup_environment

Setup the environment.

#### Example

```bash
setup_environment
```

### get_absolute_path

Get the absolute path of a file or directory.

#### Example

```bash
get_absolute_path "file.txt"
get_absolute_path "some_directory"
```

#### Arguments

* **$1** (string): The file or directory to get the absolute path of.

#### Exit codes

* **0**: If the file or directory is found.
* **1**: If the file or directory is not found.

#### Output on stdout

* The absolute path of the file or directory.

### check_shebang

Check the shebang of a file.

#### Example

```bash
check_shebang "file.py" "python3"
check_shebang "file.sh" "bash"
```

#### Arguments

* **$1** (string): The file to check the shebang of.
* **$2** (string): The interpreter to check the shebang of.

#### Exit codes

* **0**: If the shebang is correct.
* **1**: If the shebang is incorrect.

#### Output on stdout

* The shebang of the file.

### skip_if_docker

Skip if the system is a Docker system.

#### Example

```bash
skip_if_docker
```

### skip_if_not_docker

Skip if the system is not a Docker system.

#### Example

```bash
skip_if_not_docker
```

### skip_if_termux

Skip if the system is a Termux system.

#### Example

```bash
skip_if_termux
```

### skip_if_not_termux

Skip if the system is not a Termux system.

#### Example

```bash
skip_if_not_termux
```

### skip_if_linux

Skip if the system is a Linux system.

#### Example

```bash
skip_if_linux
```

### skip_if_not_linux

Skip if the system is not a Linux system.

#### Example

```bash
skip_if_not_linux
```

### skip_if_windows

Skip if the system is a Windows system.

#### Example

```bash
skip_if_windows
```

### skip_if_not_windows

Skip if the system is not a Windows system.

#### Example

```bash
skip_if_not_windows
```

