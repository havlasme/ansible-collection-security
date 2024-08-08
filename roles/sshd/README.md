Ansible Role - havlasme.security.sshd
=====================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure the [SSHd](https://www.openssh.com/) service on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/) running [systemd](https://systemd.io/).

- Install or Update the OpenSSH via APT
- Create, Update, or Delete a OpenSSH Conf File
- (Optional) Delete the Small Moduli
- Start and Enable the OpenSSH Service

Role Variables
--------------

Available variables are listed below, along with default values (see [`defaults/main.yml`](defaults/main.yml)):

```yaml
# sshd package state ('present', 'latest') - 'absent' is not supported
# * 'present' ensures that the package is installed
# * 'latest' ensures that the latest version of the package is installed
sshd__state: 'present'
# should the sshd service start at boot? (using systemd)
sshd__enabled: true
# can ansible reload the sshd service? (using systemd)
sshd__ansible_reload: true
# can ansible restart the sshd service? (using systemd)
sshd__ansible_restart: true

# sshd listen port
sshd__port: [ '22' ]
# sshd listen ip
#sshd__listen_to: [ '0.0.0.0' ]
# ssh host key type
#sshd__host_key_type: [ 'ed25519', 'rsa', 'ecdsa' ]

# sshd conf list
sshd__conf:
## - dest: string
##   tmpl: string | d(sshd__conf_template)
##   user: string | d('root')
##   group: string | d('root')
##   mode: string | d('0755')
##   backup: bool | d(false)
##   validate: bool | d(true)
##   state: enum('present', 'absent', 'directory') | d('present')
- dest: '/etc/ssh'
  state: 'directory'
- dest: '/etc/ssh/sshd_config.d'
  state: 'directory'
- dest: '/etc/ssh/sshd_config'
  tmpl: 'etc/ssh/sshd_config.j2'
- dest: '/etc/ssh/sshd_config.d/20-default-daemon.conf'
  content: |-
    PrintMotd no
    PrintLastLog yes
    AcceptEnv {{ sshd__accept_env | d('LANG LC_*') }}
- dest: '/etc/ssh/sshd_config.d/40-default-authentication.conf'
  content: |-
    PubkeyAuthentication yes
    PasswordAuthentication yes
    KbdInteractiveAuthentication no
    UsePAM yes
    PermitRootLogin {{ sshd__permit_root_login | d('prohibit-password') }}
# sshd conf default template
sshd__conf_template: '_content_.j2'

# sshd moduli file
sshd__moduli_file: '/etc/ssh/moduli'
# sshd moduli minimal size
#sshd__moduli_minsize: 3071
```

### `etc/ssh/sshd_config.d/default-cryptography-policy.conf`

```yaml title='etc/ssh/sshd_config.d/default-cryptography-policy.conf'
# the sshd cryptography policy ('infosec.mozilla.org', 'ssh-audit.com')
sshd__cryptography_policy: enum('infosec.mozilla.org', 'ssh-audit.com') | d('infosec.mozilla.org')
```

```yaml
sshd__conf:
- dest: 'sshd_config.d/20-default-cryptography-policy.conf'
  src: 'etc/ssh/sshd_config.d/default-cryptography-policy.conf.j2'
  sshd__cryptography_policy: 'ssh-audit.com'
```

Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.sshd'
```

```yaml title='Configure-Only'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.sshd'
      tasks_from: 'configure'
```

License
-------

[Apache-2.0][license-link]

Author Information
------------------

Created in 2024 by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
