GOVERSION= $(shell go version | grep ^go | cut -d " " -f 3| sed 's/go//g')
TINYGOVERSION=$(shell tinygo version | grep ^tinygo | cut -d " " -f 3)

hello: ## Run 01-hello-world example
	@echo "Hello World"
	go build -o 01-hello-world/golang-${GOVERSION} 01-hello-world/main.go
	tinygo build -o 01-hello-world/tinygo-${TINYGOVERSION}  01-hello-world/main.go

size:  ## Compare size of binaries in 01-hello-world example
	@echo "Hello World - compare sizes"
	ls -l 01-hello-world/ | grep -v main.go

blink: ## Run 02-hello-world-iot example
	@echo "Show how microbit can blink"
	tinygo build -target microbit -o=/Volumes/MICROBIT/flash.hex 02-hello-world-iot/main.go

display: ## Run 03-microbit-display example
	@echo "Show how microbit display works"
	tinygo build -target microbit -o=/Volumes/MICROBIT/flash.hex 03-microbit-display/main.go

buttons:  ## Run 04-microbit-buttons example
	@echo "Show how microbit buttons works"
	tinygo build -target microbit -o=/Volumes/MICROBIT/flash.hex 04-microbit-buttons/main.go

gpio:  ## Run 05-microbit-gpio example
	@echo "Show how microbit gpio works"
	tinygo build -target microbit -o=/Volumes/MICROBIT/flash.hex 05-microbit-gpio/main.go

hex:  ## Run 05-microbit-gpio example with hex
	@echo "Show how microbit gpio works using hex"
	cp 05-microbit-gpio/example.hex /Volumes/MICROBIT/flash.hex


clean: ## Clean after run compiles
	rm 01-hello-world/golang-*
	rm 01-hello-world/tinygo-*

##@ Other
#------------------------------------------------------------------------------
help:  ## Display help
	@awk 'BEGIN {FS = ":.*##"; printf "Usage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
#------------- <https://suva.sh/posts/well-documented-makefiles> --------------

.DEFAULT_GOAL := help
.PHONY: help clean size hello blink display gpio buttons hex
