Ansible Collection - havlasme.security
====================================== 

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) collection of security related roles, plugins, and modules:

- [havlasme.security.borgbackup](/roles/borgbackup/README.md)
- [havlasme.security.molly_guard](/roles/molly_guard/README.md)
- [havlasme.security.nftables](/roles/nftables/README.md)
- [havlasme.security.sshd](/roles/sshd/README.md)


Installation
------------

```shell
ansible-galaxy collection install havlasme.security
```

```yaml title="requirements.yml"
---
collections:
- name: havlasme.security
```


Development
-----------

```shell
make build
```

```shell title="ansible-lint"
make lint
```

```shell title="molecule"
make test
```


License
-------

[Apache-2.0][license-link]


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: LICENSE
