Ansible Role - havlasme.security.nftables
=========================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure the firewall using [nftables](https://nftables.org/) on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/).

- Install, Update or Uninstall the NFTables via APT
- Create, Update, or Delete a NFTables Conf File
- Start/Stop and Enable/Disable the NFTables Service

Role Variables
--------------

```yaml
# the nftables package state ('present', 'latest', 'absent')
nftables__state: 'present'
# should start the nftables service at boot
nftables__enabled: '{{ nftables__state != "absent" }}'
# can ansible reload nftables service?
nftables__ansible_reload: true
# can ansible restart nftables service?
nftables__ansible_restart: true

# the nftables conf list
## - dest: string
##   tmpl: string | d(nftables__conf_template)
##   state: enum('present', 'absent') | d('present')
nftables__conf:
- dest: '/etc/nftables.conf'
  tmpl: 'etc/nftables.conf.j2'
# the nftables conf default template
nftables__conf_template: '[content].conf.j2'
# the nftables conf directory
nftables__confdir: '/etc/nftables.d'
```

### `etc/nftables.d/zerotrust-stateful-firewall.conf.j2`

```yaml title='etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
# allow icmp ping traffic at the input chain
nftables__accept_ping: true
# allow multicast traffic at the input chain
nftables__accept_multicast: false

# the ssh service port
nftables__ssh_port: 22
# the ssh service ipv4 accept list
nftables__ssh_ipv4_accept: [ '0.0.0.0/0' ]
# the ssh service ipv6 accept list
nftables__ssh_ipv6_accept: [ '::/0' ]
```

```yaml
nftables__conf:
- dest: '10-zerotrust-stateful-firewall.conf'
  src: 'etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
```

Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.nftables'
    vars:
      nftables__conf:
      - dest: '/etc/nftables.conf'
        src: 'etc/nftables.conf.j2'
      - dest: '10-zerotrust-stateful-firewall.conf'
        src: 'etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
```

```yaml title='Configure-Only'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.nftables'
      tasks_from: 'configure'
    vars:
      nftables__conf:
      - dest: '10-zerotrust-stateful-firewall.conf'
        src: 'etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
