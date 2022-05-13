havlasme.security.borgmatic
===========================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to manage borgmatic.

Requirements
------------

None.

Role Variables
--------------

```yaml
# the borgmatic package state ('present', 'absent', 'latest')
borgmatic_state: "present"

# the borgmatic configuration directory
borgmatic_confdir: "/etc/borgmatic.d"

# the borgmatic job default template
borgmatic_job_template: "generic.yaml.j2"
# the borgmatic job list
borgmatic_job: []
# - name: string
#   key: string
#   passphrase: string
#   repository:
#     name: string
#     host_key: string
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
      name: havlasme.security.borgmatic
    vars:
      borgmatic_job:
# TODO
```

License
-------

Apache-2.0

Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).

[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
