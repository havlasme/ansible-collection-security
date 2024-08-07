Ansible Role - havlasme.security.molly_guard
============================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure the Molly-Guard on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/) running [systemd](https://systemd.io/).

- Install, Update, or Uninstall the Molly-Guard via APT

Role Variables
--------------

Available variables are listed below, along with default values (see [`defaults/main.yml`](defaults/main.yml)):

```yaml
# molly-guard package state ('present', 'latest, 'absent')
# * 'present' ensures that the package is installed
# * 'latest' ensures that the latest version of the package is installed
# * 'absent' ensures that the package is not installed
molly_guard__state: 'present'
```

Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.molly_guard'
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
