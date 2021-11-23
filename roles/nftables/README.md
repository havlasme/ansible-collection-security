havlasme.security.nftables
==========================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to manage nftables.

Requirements
------------

None.

Role Variables
--------------

```yaml
# the nftables main configuration
nftables_conf: "/etc/nftables.conf"
# the nftables main configuration template
nftables_conf_template: "main.conf.j2"
# the nftables configuration drop-in directory
nftables_confd: "/etc/nftables.d"
# the nftables ruleset
nftables_ruleset: []
# - src: string
#   dest: string
#   state: string
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
      name: havlasme.security.nftables
    vars:
      nftables_ruleset:
      - src: "ruleset-simple-stateful-firewall.conf.j2"
        dest: "10-simple-stateful-firewall.conf"
```

License
-------

Apache-2.0

Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).

[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
