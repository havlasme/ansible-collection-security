Ansible Role - havlasme.security.nftables
=========================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure firewall using [nftables](https://nftables.org/) on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/).

- Install, Update or Uninstall the NFTables Package via APT
- Create, Update, or Delete a NFTables Conf File
- Start and Enable the NFTables Service

Role Variables
--------------

```yaml
# the nftables package state ('present', 'latest', 'absent')
nftables_state: 'present'
# should start the nftables service at boot
nftables_enabled: true
# can ansible reload nftables service?
nftables_ansible_reload: true
# can ansible restart nftables service?
nftables_ansible_restart: true

# the nftables conf list
## - dest: string
##   tmpl: string | d(nftables_conf_template)
##   state: enum('present', 'absent') | d('present')
nftables_conf:
- dest: '/etc/nftables.conf'
  tmpl: 'etc/nftables.conf.j2'
# the nftables conf default template
nftables_conf_template: 'etc/nftables.d/[content].conf.j2'
# the nftables conf directory
nftables_conf_d: '/etc/nftables.d'
```

### `etc/nftables.d/simple-stateful-firewall.conf.j2`

```yaml title='etc/nftables.d/simple-stateful-firewall.conf.j2'
# allow icmp ping traffic at the input chain
nftables_accept_ping: 'yes'
# allow multicast traffic at the input chain
nftables_accept_multicast: 'no'

# the ssh service port
nftables_ssh_port: 22
# the ssh service ipv4 accept list
nftables_ssh_ipv4_accept: [ '0.0.0.0/0' ]
# the ssh service ipv6 accept list
nftables_ssh_ipv6_accept: [ '::/0' ]
```

```yaml
nftables_conf:
- dest: '10_simple-stateful-firewall.conf'
  src: 'etc/nftables.d/simple-stateful-firewall.conf.j2'
```

Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.nftables'
    vars:
      nftables_conf:
      - dest: '/etc/nftables.conf'
        src: 'etc/nftables.conf.j2'
      - dest: '10_simple-stateful-firewall.conf'
        src: 'etc/nftables.d/simple-stateful-firewall.conf.j2'
```

```yaml title='Configure-Only'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.nftables'
      tasks_from: 'configure-only'
    vars:
      nftables_conf:
      - dest: '/etc/nftables.conf'
        src: 'etc/nftables.conf.j2'
      - dest: '10_simple-stateful-firewall.conf'
        src: 'etc/nftables.d/simple-stateful-firewall.conf.j2'
```

License
-------

[Apache-2.0][license-link]


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
