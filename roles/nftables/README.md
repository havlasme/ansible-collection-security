Ansible Role - havlasme.security.nftables
=========================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure the firewall using [nftables](https://nftables.org/) on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/) running [systemd](https://systemd.io/).

- Install, Update or Uninstall the NFTables via APT
- Create, Update, and Delete a NFTables Conf File
- Start/Stop and Enable/Disable the NFTables Service

Role Variables
--------------

Available variables are listed below, along with default values (see [`defaults/main.yml`](defaults/main.yml)):

```yaml
# nftables package state ('present', 'latest', 'absent')
# * 'present' ensures that the package is installed
# * 'latest' ensures that the latest version of the package is installed
# * 'absent' ensures that the package is not installed
nftables__state: 'present'
# should start the nftables service at boot? (using systemd)
nftables__enabled: '{{ nftables__state != "absent" }}'
# can ansible reload the nftables service? (using systemd)
nftables__ansible_reload: true
# can ansible restart the nftables service? (using systemd)
nftables__ansible_restart: true

# nftables conf list
#! template lookup is done by the `havlasme.ansible.template` plugin
nftables__conf:
## - dest: string
##   template: string | d(nftables__conf_template)
##   user: string | d('root')
##   group: string | d('root')
##   mode: string | d('0755')
##   backup: boolean | d(false)
##   state: enum('present', 'absent', 'directory') | d('present')
- dest: '/etc/nftables.d'
  state: 'directory'
- dest: '/etc/nftables.conf'
  template: 'etc/nftables.conf.j2'
# nftables conf default template
nftables__conf_template: '_content_.j2'
```

### `etc/nftables.d/zerotrust-stateful-firewall.conf.j2`

```yaml title='etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
# allow icmp ping traffic at the input chain
nftables__accept_ping: true
# allow multicast traffic at the input chain
nftables__accept_multicast: false

# ssh service port
nftables__ssh_port: 22
# ssh service ipv4 accept list
nftables__ssh_ipv4_accept: [ '0.0.0.0/0' ]
# ssh service ipv6 accept list
nftables__ssh_ipv6_accept: [ '::/0' ]
```

```yaml
nftables__conf:
- dest: '/etc/nftables.d/10-zerotrust-stateful-firewall.conf'
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
        template: 'etc/nftables.conf.j2'
      - dest: '/etc/nftables.d/10-zerotrust-stateful-firewall.conf'
        template: 'etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
```

```yaml title='Configure-Only'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.nftables'
      tasks_from: 'configure'
    vars:
      nftables__conf:
      - dest: '/etc/nftables.d/10-zerotrust-stateful-firewall.conf'
        template: 'etc/nftables.d/zerotrust-stateful-firewall.conf.j2'
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
