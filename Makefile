SHELL = sh

default: test

.PHONY: test
test: vet
	@echo "--> Running Tests ..."
	@go test -v -race ./...

.PHONY: lint
lint: vet
	@echo "--> Linting Go sources ..."
	@golangci-lint run --config .github/workflows/scripts/golangci.yaml

.PHONY: vet
vet:
	@echo "--> Vet Go sources ..."
	@go vet ./...

.PHONY: copywrite
copywrite:
	@echo "--> Checking Copywrite ..."
	copywrite \
		--config .github/workflows/scripts/copywrite.hcl headers \
		--spdx "MPL-2.0"

.PHONY: release
release:
	envy exec gh-release goreleaser release --clean
	$(MAKE) clean

