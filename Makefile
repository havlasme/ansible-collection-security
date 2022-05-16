NAMESPACE = $(shell yq -r .namespace galaxy.yml)
ROLENAME = $(shell yq -r .name galaxy.yml)
ROLEVERSION = $(shell yq -r .version galaxy.yml)
DIST = ./dist
GALAXY = @ansible-galaxy

.PHONY: build
build:
	$(GALAXY) collection build --output-path "$(DIST)"

.PHONY: clean
clean:
	-rm --recursive "$(DIST)"

.PHONY: install
install:
	$(GALAXY) collection install "$(DIST)/$(NAMESPACE)-$(ROLENAME)-$(ROLEVERSION).tar.gz"

.PHONY: test
test:
	$(MAKE) -C roles/borgbackup test
	$(MAKE) -C roles/borgmatic test
	$(MAKE) -C roles/nftables test
	$(MAKE) -C roles/ssh_key test
