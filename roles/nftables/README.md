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
# the nftables package state ('present', 'latest')
nftables_state: "present"
# start the nftables service at system boot
nftables_service_enabled: "yes"
# can ansible restart nftables service
nftables_service_restart: "yes"

# the nftables configuration directory
nftables_confdir: "/etc/nftables.d"

# the nftables main configuration file
nftables_conf_main: "/etc/nftables.conf"
# the nftables main configuration template
#nftables_conf_tmpl: "nftables.conf.j2"

# the nftables ruleset default template
# * ruleset.d/minimal.conf.j2  minimalistic template
# * ruleset.d/simple-stateful-firewall.conf.j2  an opinionated stateful firewall setup
nftables_ruleset_tmpl: "ruleset.d/minimal.conf.j2"
# the nftables ruleset list
nftables_ruleset: []
# - dest: string
#   src: string
#   state: enum('present', 'absent') | d('present')
# * ruleset.d/minimal.conf.j2
#   ruleset: string[]
# * ruleset.d/simple-stateful-firewall.conf.j2
#   accept_ping: boolean | d('yes')
#   accept_multicast: boolean | d('no')
#   ssh_port: int | d(22)
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
