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

# the borgmatic cronjob configuration
borgmatic_cronjob:
  hour: 2
  minute: 30

# the borgmatic job default template
# * minimal.yaml.j2  a minimalistic template
# * directory.yaml.j2  an opinionated template to backup directory
borgmatic_job_tmpl: "minimal.yaml.j2"
# the borgmatic job list
borgmatic_job: []
# - name: string
#   key: string
#   passphrase: string
#   repository:
#     name: string
#     host_key: string
#  template: string | d(borgmatic_job_tmpl)
# * template: minimal.yaml.j2
#   location: yaml
#   storage: yaml | d(omit)
#   retention: yaml
#   consistency: yaml | d(omit)
#   hook: yaml | d(omit)
# * template: directory.yaml.j2
#   directory: string[]
#   compression: string | d('auto,zstd')
#   exclude_mark: string | d('.nobackup')
#   retention: dict
#     daily: int | d(7)
#     weekly: int | d(4)
#     monthly: int | d(6)
#     yearly: int | d(1)
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
