MOLECULE = @molecule

.PHONY: lint
lint:
	$(ANSIBLE_LINT) -c ./.ansible-lint .

.PHONY: test
test:
	$(MOLECULE) test --all
