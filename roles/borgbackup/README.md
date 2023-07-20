havlasme.security.borgbackup
============================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure [borgbackup](https://www.borgbackup.org/) on [Debian](https://www.debian.org/) and [Ubuntu](https://ubuntu.com/).

* install or update borgbackup package via apt
* create borgbackup configuration directory structure
* create borgbackup systemd service unit
* create, update, or delete borgbackup repository user *(at repository host)*
* create borgbackup repository ssh directory *(at repository host)*
* create borgbackup client group
* create borgbackup client user
* create borgbackup client ssh configuration directory
* generate borgbackup client ssh key
* add repository host key to known host list
* delete borgbackup job configuration
* create or update borgbackup job configuration
* download borgbackup client public ssh key
* configure borgbackup client ssh key at repository *(at repository host)*
* initialize borgbackup repository
* create borgbackup management group *(at management host)*
* create borgbackup management user *(at management host)*
* create borgbackup management ssh configuration directory *(at management host)*
* generate borgbackup management ssh key *(at management host)*
* add repository host key to known host list *(at management host)*
* create borgbackup management configuration directory *(at management host)*
* create or update borgbackup management configuration directory *(at management host)*
* create or update borgbackup management configuration *(at management host)*
* download borgbackup management public ssh key *(at management host)*
* configure borgbackup management ssh key at repository *(at repository host)*


Role Variables
--------------

```yaml
# the borgbackup package state ('present', 'latest')
borgbackup_state: 'present'
# should start the borgbackup service at boot
borgbackup_enabled: true
# the borgbackup service option
borgbackup_service_option:
- '--config {{ borgbackup_job_d | quote }}'
- '--verbosity -1'
- '--syslog-verbosity 1'

# the borgbackup dedicated user
borgbackup_user: 'root'
# the borgbackup dedicated group
borgbackup_group: '{{ borgbackup_user }}'
# the borgbackup dedicated home directory
borgbackup_home: '/root'

# the borgbackup job list
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
##     state: enum('present', 'absent') | d('present')
##   template: string | d(borgbackup_job_template)
##   state: enum('present', 'absent') | d('present')
borgbackup_job: []
# the borgbackup job default template
borgbackup_job_template: 'etc/borgbackup/__default__.yaml.j2'
# the borgbackup job.d directory
borgbackup_job_d: '/etc/borgbackup'
# the borgbackup ssh key type
borgbackup_ssh_key_type: 'ed25519'

# the borgbackup management job default template
borgbackup_management_template: '{{ borgbackup_job_template }}'
# the borgbackup management.d directory
borgbackup_management_d: '/etc/borgbackup/management.d'
# the borgbackup management ssh key type
borgbackup_management_ssh_key_type: '{{ borgbackup_ssh_key_type }}'
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
- hosts: all
  tasks:
  - import_role:
      name: havlasme.security.borgbackup
    vars:
      borgbackup_repository:
      - name: "{{ inventory_hostname }}"
```


License
-------

Apache-2.0


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
