havlasme.security.borgbackup
============================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure [borgbackup](https://www.borgbackup.org/) using [borgmatic](https://torsion.org/borgmatic/) on [Debian](https://www.debian.org/) and [Ubuntu](https://ubuntu.com/) running [systemd](https://systemd.io/).

Role Variables
--------------

Available variables are listed below, along with default values (see [`defaults/main.yml`](defaults/main.yml)):

```yaml
# borgbackup package state ('present', 'latest', 'absent')
# * 'present' ensures that the package is installed
# * 'latest' ensures that the latest version of the package is installed
# * 'absent' ensures that the package is not installed
borgbackup__state: 'present'
# should start the borgbackup service at boot? (using systemd)
borgbackup__enabled: '{{ borgbackup__state != "absent" }}'
# can ansible reload the borgbackup service? (using systemd)
borgbackup__ansible_reload: true
# can ansible restart the borgbackup service? (using systemd)
borgbackup__ansible_restart: true

# borgbackup systemd service user
borgbackup__user: 'root'
# borgbackup systemd service group
borgbackup__group: 'root'
# borgbackup systemd service working directory
borgbackup__home: '/root'

# borgbackup job list
borgbackup__job: [ ]
## - name: string
##   passphrase: string
##   encryption: string | d('repokey')
##   repository: dict[]
##   - host: string
##     user: string
##     home: string
##     group: string | d(item.user)
##     append_only: boolean | d(false)
##     host_pub_key: string | d(omit)
##     management: dict | d(omit)
##       host: string
##       user: string | d('root')
##       home: string | d(omit)
##       group: string | d(item.user)
##       template: string | d(borgbackup__management_template)
##     state: enum('present', 'absent') | d('present')
##   template: string | d(borgbackup__job_template)
##   state: enum('present', 'absent') | d('present')
# borgbackup job default template
borgbackup__job_template: '_content_.j2'
# borgbackup management job default template
borgbackup__management_template: '{{ borgbackup__job_template }}'
# borgbackup ssh key type
borgbackup__ssh_key_type: 'ed25519'

# borgbackup service environment template
# this template will be deployed at `/etc/default/borgbackup` which is referenced by the systemd service
borgbackup__env_template: 'etc/default/borgbackup.j2'
```

Dependencies
------------

[Ansible.Posix](https://docs.ansible.com/ansible/latest/collections/ansible/posix/index.html)

```bash
ansible-galaxy collection install ansible.posix
```

[Community.Crypto](https://docs.ansible.com/ansible/latest/collections/community/crypto/index.html)

```bash
ansible-galaxy collection install community.crypto
```

Example Playbook
----------------

```yaml
- hosts: 'all'
  
  tasks:
  - ansible.builtin.import_role:
      name: 'havlasme.security.borgbackup'
```

License
-------

[Apache-2.0][license-link]


Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
