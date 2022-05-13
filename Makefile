GALAXY = @ansible-galaxy

.PHONY: build
build:
	$(GALAXY) collection build --output-path ./dist

.PHONY: clean
clean:
	rm -r ./dist

.PHONY: test
test:
	$(MAKE) -C roles/borgbackup test
	$(MAKE) -C roles/borgmatic test
	$(MAKE) -C roles/nftables test
	$(MAKE) -C roles/ssh_key test
