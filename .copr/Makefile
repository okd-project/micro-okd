mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

.PHONY: srpm
srpm:
	@echo "Installing dependencies"
	dnf install -y dnf-plugins-core rpmdevtools git golang yq python3-pyyaml python3-pygithub python3-GitPython \
		python3-tabulate python3-tqdm python3-jira python3-flake8 jq gettext-envsubst
	@echo "Installing oc client"
	$(MAKE) -C $(current_dir)/.. oc-client BIN=/usr/bin

	# Set git user info
	git config --global user.email "build-robot@okd.io"
	git config --global user.name "OKD Build Robot"

	@echo "Building SRPM"
	$(MAKE) -C $(current_dir)/.. patch
	$(MAKE) -C $(current_dir)/.. srpm
	@echo "Copying SRPM to $(outdir)"
	mkdir -p $(outdir)
	cp $(current_dir)/../upstream/_output/rpmbuild/SRPMS/* $(outdir)/