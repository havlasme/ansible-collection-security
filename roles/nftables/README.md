havlasme.security.nftables
==========================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure nftables on [Debian](https://www.debian.org/).


Role Variables
--------------

```yaml
# the nftables package state ('present', 'latest')
nftables_state: 'present'
# should start the nftables service at boot
nftables_enabled: true
# can ansible reload nftables service?
nftables_ansible_reload: true
# can ansible restart nftables service?
nftables_ansible_restart: true

# the nftables conf file
nftables_conf_file: '/etc/nftables.conf'
# the nftables conf template
nftables_conf_template: 'etc/nftables.conf.j2'

# the nftables conf.d directory
nftables_conf_d: '/etc/nftables.d'
# the nftables conf.d file list
## - dest: string
##   src: string | d(nftables_conf_d_template)
##   state: enum('present', 'absent') | d('present')
## * etc/nftables.d/simple_stateful_firewall.conf.j2
##   nftables_accept_ping: boolean | d(true)
##   nftables_accept_multicast: boolean | d(false)
##   nftables_ssh_port: integer | d(22)
nftables_conf_d_file: []
# the nftables conf.d default template
nftables_conf_d_template: 'etc/nftables.d/__default__.conf.j2'
```

### `etc/nftables.d/simple_stateful_firewall.conf.j2`

```yaml title='etc/nftables.d/simple_stateful_firewall.conf.j2'
# allow icmp ping traffic at the input chain
nftables_accept_ping: true
# allow multicast traffic at the input chain
nftables_accept_multicast: false
# open ssh service port
nftables_ssh_port: 22
```

```yaml
nftables_conf_d_file:
- dest: '10-simple-stateful-firewall.conf'
  src: 'etc/nftables.d/simple_stateful_firewall.conf.j2'
```


Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - include_role:
      name: 'havlasme.security.nftables'
```


License
-------

Apache-2.0


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
