GALAXY = @ansible-galaxy
NAMESPACE = $(shell yq -r .namespace galaxy.yml)
ROLENAME = $(shell yq -r .name galaxy.yml)
ROLEVERSION = $(shell yq -r .version galaxy.yml)
DIST = ./dist

.PHONY: build
build:
	$(GALAXY) collection build --output-path "$(DIST)"

.PHONY: clean
clean:
	-rm --recursive "$(DIST)"

.PHONY: install
install:
ifeq (, $(shell which yq))
	$(error "no yq. try doing pip3 install yq")
else
	$(GALAXY) collection install "$(DIST)/$(NAMESPACE)-$(ROLENAME)-$(ROLEVERSION).tar.gz"
endif

.PHONY: lint
lint:
	#$(MAKE) -C roles/borgbackup lint
	#$(MAKE) -C roles/molly_guard lint
	$(MAKE) -C roles/nftables lint
	#$(MAKE) -C roles/sshd lint

.PHONY: test
test:
	#$(MAKE) -C roles/borgbackup test
#	$(MAKE) -C roles/molly_guard test
	$(MAKE) -C roles/nftables test
	#$(MAKE) -C roles/sshd test
