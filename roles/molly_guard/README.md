havlasme.security.molly_guard
=============================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure Molly-Guard on [Debian](https://www.debian.org/) or [Ubuntu](https://www.ubuntu.com/).

* Install, Update, or Uninstall Molly-Guard Package via APT

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

Apache-2.0


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
