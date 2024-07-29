Ansible Role - havlasme.security.sshd
=====================================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure the [SSHd](https://www.openssh.com/) service on [Debian](https://www.debian.org/) and [Ubuntu](https://www.ubuntu.com/).

- Install or Update the OpenSSH via APT
- (Optional) Create or Update the `issue` File
- Create, Update, or Delete a OpenSSH Conf File
- (Optional) Delete the Small Moduli
- Start and Enable the OpenSSH Service

Role Variables
--------------

```yaml
# the sshd package state ('present', 'latest') - 'absent' is not supported
sshd_state: 'present'
# should the sshd service start at boot
sshd_enabled: true
# can ansible reload sshd service?
sshd_ansible_reload: true
# can ansible restart sshd service?
sshd_ansible_restart: true

# the sshd listen port
sshd_port: [ '22' ]
# the sshd listen ip
#sshd_ip: [ '0.0.0.0' ]
# the ssh host key type
#sshd_host_key_type: [ 'ed25519', 'rsa', 'ecdsa' ]

# the sshd conf list
## - dest: string
##   tmpl: string | d(sshd_conf_template)
##   state: enum('present', 'absent') | d('present')
sshd_conf:
- dest: 'sshd_config'
  tmpl: 'etc/ssh/sshd_config.j2'
## allow client to set the locale environment
- dest: 'sshd_config.d/20-base-daemon.conf'
  content: |-
    PrintMotd no
    PrintLastLog yes

    AcceptEnv {{ sshd_accept_env | d('LANG LC_*') }}
## basic password or pubkey authentication
- dest: 'sshd_config.d/40-base-authentication.conf'
  content: |-
    PubkeyAuthentication yes
    PasswordAuthentication yes
    KbdInteractiveAuthentication no
    UsePAM yes

    PermitRootLogin {{ sshd_permit_root_login | d('prohibit-password') }}
# the sshd conf default template
sshd_conf_template: 'etc/ssh/sshd_config.d/[content].conf.j2'
# the sshd conf directory
sshd_confdir: '/etc/ssh'

# the sshd moduli file
sshd_moduli_file: '/etc/ssh/moduli'
# the sshd moduli minimal size
#sshd_moduli_minsize: 3071
```

### `etc/ssh/sshd_config.d/default-cryptography-policy.yml`

```yaml title='etc/ssh/sshd_config.d/default-cryptography-policy.yml'
# the sshd cryptography policy ('infosec.mozilla.org', 'ssh-audit.com')
sshd_crypto_policy: enum('infosec.mozilla.org', 'ssh-audit.com') | d('infosec.mozilla.org')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/20-crypto-policy-ssh-audit.yml'
  src: 'etc/ssh/sshd_config.d/crypto-policy.yml.j2'
  sshd_crypto_policy: 'ssh-audit.com'
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

Created by [Tomáš Havlas](https://havlas.me/).


[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
