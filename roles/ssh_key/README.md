havlasme.security.ssh_key
=========================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to manage ssh private key.

Requirements
------------

None.

Role Variables
--------------

```yaml
---
# the ssh key list
ssh_key: []
# - dest: string
#   src: string
#   state: string | d('present')
```

Dependencies
------------

None.

Example Playbook
----------------

```yaml
- hosts: all
  tasks:
  - import_role:
      name: havlasme.security.ssh_key
    vars:
# TODO
```

License
-------

Apache-2.0

Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).

[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
