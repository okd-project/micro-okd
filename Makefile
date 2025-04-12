VERSION ?= $(shell git describe --tags --exact-match 2>/dev/null || echo $$(git rev-parse --abbrev-ref HEAD)-$$(git rev-parse --short HEAD))

BASE_IMAGE ?= quay.io/okd/scos-release
IMAGE ?= $(BASE_IMAGE):$(VERSION)
LVMS_BUNDLE ?= quay.io/okderators/lvms-operator-bundle:4.18.0-2025-02-25-114001

OKD_VERSION ?= 4.18

BIN=$(shell pwd)/bin
OC=$(BIN)/oc

ARCH ?= $(shell uname -m)
ifeq ($(ARCH),x86_64)
	OC_CLIENT=openshift-client-linux-$(VERSION)
else ifeq ($(ARCH),aarch64)
	OC_CLIENT=openshift-client-linux-arm64-$(VERSION)
else ifeq ($(ARCH),ppc64le)
	OC_CLIENT=openshift-client-linux-ppc64le-$(VERSION)
else
	OC_CLIENT=openshift-client-linux-$(ARCH)-$(VERSION)
endif

.PHONY: oc-client
oc-client:
	@echo "Downloading OKD client for Linux..."
	mkdir -p $(BIN)
	curl -L -o $(BIN)/$(OC_CLIENT).tar.gz https://github.com/okd-project/okd-scos/releases/download/$(VERSION)/$(OC_CLIENT).tar.gz
	@echo "Extracting OKD client..."
	tar -xzf $(BIN)/$(OC_CLIENT).tar.gz -C $(BIN)
	@echo "Cleaning up..."
	rm $(BIN)/$(OC_CLIENT).tar.gz $(BIN)/README.md
	@echo "OKD client is ready in the bin directory."

.PHONY: clean
clean:
	cd upstream && \
		git clean -xfd && \
		git checkout release-$(OKD_VERSION) && \
		git reset --hard origin/release-$(OKD_VERSION)


.PHONY: patch
patch: clean
	cd upstream && \
		../scripts/apply-patches.sh && \
		./scripts/auto-rebase/rebase.sh to $(IMAGE) $(IMAGE) && \
		./scripts/auto-rebase/rebase-lvms.sh to $(LVMS_BUNDLE)

PHONY: srpm
srpm:
	cd upstream && make srpm MICROSHIFT_VERSION=$(VERSION)