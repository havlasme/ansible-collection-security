havlasme.security.borgbackup
============================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to manage borgbackup.

Requirements
------------

None.

Role Variables
--------------

```yaml
# the borgbackup state ('present', 'absent', 'latest')
borgbackup_state: "present"
# the borgbackup data directory
borgbackup_datadir: "/var/lib/borgbackup"
# the borgbackup repository list
borgbackup_repository: []
# - name: string
#   comment: string
#   key: string
#   storage: string
#   state: string
```

Dependencies
------------

[havlasme.linux](https://gitlab.com/havlas.me/ansible-collection-linux)

```bash
ansible-galaxy collection install havlasme.linux
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
