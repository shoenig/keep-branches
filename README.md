# keep-branches

<img align="right" width="240" height="244" src="https://i.imgur.com/dcoTPpR.png">

`keep-branches` is a CLI tool used to prune local git repository of unwanted branches.

The tool will prune branches that are

- not `main`
- not the current branch
- not listed as an argument


[![GitHub](https://img.shields.io/github/license/shoenig/keep-branches.svg)](LICENSE)

## Install

The `keep-branches` tool is available to download from the [Releases](https://github.com/shoenig/keep-branches/releases) page.

It is pre-compiled for many operating systems and architectures including

- Linux
- Windows
- MacOS
- FreeBSD
- OpenBSD

## Build

The `keep-branches` command can be compiled from source using the Go tool chain.

Short version:

```shell
go install github.com/shoenig/keep-branches@latest
```

## Examples

Keep only `main`

```shell
keep-branches
```

Keep `main`, `x-my-branch`, `x-foo-branch`

```shell
keep-branches x-my-branch x-foo-branch
```

Print help message

```shell
keep-branches -help
```

## Contributing

The `github.com/shoenig/keep-branches` command is always improving with new
features and bug fixes. For contributing please file an issue or pull request.

## License

The `github.com/shoenig/keep-branches` command is open source under the [MPL 2.0](LICENSE) license.
