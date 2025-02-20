# bats-alimektor #

![ubuntu](https://github.com/Alimektor/bats-alimektor/actions/workflows/ubuntu.yml/badge.svg) ![alpine](https://github.com/Alimektor/bats-alimektor/actions/workflows/alpine.yml/badge.svg) ![docs](https://github.com/Alimektor/bats-alimektor/actions/workflows/docs.yml/badge.svg) ![pre-commit](https://github.com/Alimektor/bats-alimektor/actions/workflows/pre-commit.yml/badge.svg)

A [Bats](https://github.com/bats-core/bats-core) library with useful Bash functions.

## Installation ##

### [Copier](https://github.com/copier-org/copier) ###

> It install library and necessary dependencies for current user.

> [!IMPORTANT]
> It is recommended to use the copier to install this library.

```bash
copier copy --trust https://github.com/Alimektor/bats-alimektor <path>
```

Specify name, description and file_tags for your first test.

### [Make](https://www.gnu.org/software/make/) ###

> It only install library, not full Bats with necessary dependencies.

Install for all system:

```bash
make install
```

Install for current user:

```bash
make install LOCAL=true
```

## Usage ##

```bash
bats_load_library "bats-alimektor"
```

## Docs ##

For more information on how to use the functions, please refer to the [docs](docs/functions.md).

## License ##

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for details.
