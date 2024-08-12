Ansible Collection - havlasme.security
====================================== 

[![CI][gitlabci-image]][gitlabci-link]
[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) collection of linux security related content that supports [Debian](https://www.debian.org/) and [Ubuntu](https://ubuntu.com/) running [systemd](https://systemd.io/).

### Included Content

- `havlasme.security.borgbackup` ([documentation](/roles/borgbackup/README.md))
- `havlasme.security.molly_guard` ([documentation](/roles/molly_guard/README.md))
- `havlasme.security.nftables` ([documentation](/roles/nftables/README.md))
- `havlasme.security.sshd` ([documentation](/roles/sshd/README.md))

Installation
------------

```shell
ansible-galaxy collection install havlasme.security
```

```yaml
---
collections:
- name: 'havlasme.security'
...
```

Development
-----------

```shell
make build
```

```shell
make lint
```

```shell
make test
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: LICENSE

[gitlabci-image]: https://img.shields.io/gitlab/pipeline-status/havlas.me/ansible-collection-security?style=flat-square
[gitlabci-link]: https://gitlab.com/havlas.me/ansible-collection-security/-/pipelines
