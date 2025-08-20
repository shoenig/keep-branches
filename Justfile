set shell := ["bash", "-u", "-c"]

export scripts := ".github/workflows/scripts"
export GOBIN := `echo $PWD/.bin`

# show available commands
[private]
default:
    @just --list

# locally install build dependencies
[group('setup')]
init:
    go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@v2.0.2
    go install github.com/hashicorp/copywrite@v0.22.0

# show host system information
[group('setup')]
@sysinfo:
    echo "{{os()/arch()}} {{num_cpus()}}c"

# ensure copywrite headers present on source files
copywrite:
    $GOBIN/copywrite --config .github/workflows/scripts/copywrite.hcl headers --spdx "MIT"

# tidy up Go modules
[group('build')]
tidy:
    go mod tidy

# run tests across source tree
[group('build')]
tests:
    go test -v -race -count=1 ./...

# apply go vet command on source tree
[group('lint')]
vet:
    go vet ./...

# apply golangci-lint linters on source tree
[group('lint')]
lint: vet
    $GOBIN/golangci-lint run --config {{scripts}}/golangci.yaml
