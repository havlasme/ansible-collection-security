Ansible Role - havlasme.security.molly_guard
============================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure Molly-Guard on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/).

- Install, Update, or Uninstall the Molly-Guard Package via APT

Role Variables
--------------

```yaml
# the molly-guard package state ('present', 'latest, 'absent')
molly_guard_state: 'present'
```

Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - include_role:
      name: 'havlasme.security.molly_guard'
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
