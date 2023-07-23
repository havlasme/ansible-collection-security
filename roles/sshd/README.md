havlasme.security.sshd
======================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure [sshd](https://www.openssh.com/) service on [Debian](https://www.debian.org/) or [Ubuntu](https://www.ubuntu.com/).


Role Variables
--------------

```yaml
# the sshd package state ('present', 'latest')
sshd_state: 'present'
# should start the sshd service at boot
sshd_enabled: true

# the sshd port
sshd_port: [ '22' ]
# the sshd listen
#sshd_listen: [ '0.0.0.0' ]
# the ssh host key type
#sshd_host_key_type: [ 'ed25519', 'rsa', 'ecdsa' ]

# the sshd conf list
## - dest: string
##   src: string | d(sshd_conf_template)
##   state: enum('present', 'absent') | d('present')
sshd_conf:
- dest: '/etc/ssh/sshd_config'
  src: 'etc/ssh/sshd_config.j2'
## basic password or pubkey authentication
- dest: '20-password-authentication.conf'
  src: 'etc/ssh/sshd_config.d/authentication.conf.j2'
## allow client to set the locale environment variables
- dest: '40-accept-env-locale-only.conf'
  src: 'etc/ssh/sshd_config.d/accept-env.conf.j2'
  sshd_accept_env: 'LANG LC_*'
# the sshd conf.d default template
sshd_conf_template: 'etc/ssh/sshd_config.d/__default__.conf.j2'
# the sshd conf.d directory
sshd_conf_d: '/etc/ssh/sshd_config.d'

# the sshd moduli file
sshd_moduli_file: '/etc/ssh/moduli'
# the sshd moduli minimal size
#sshd_moduli_minsize: 3071
```

### `etc/ssh/sshd_config.d/accept-env.yml`

```yaml title='etc/ssh/sshd_config.d/accept-env.yml'
# accept env sent by the ssh client
sshd_accept_env: 'no'
```

```yaml
sshd_conf:
- dest: '40-accept-env-locale-only.yml'
  src: 'etc/ssh/sshd_config.d/accept-env.yml.j2'
  sshd_accept_env: 'LANG LC_*'
```

### `etc/ssh/sshd_config.d/allow-group.yml`

```yaml title='etc/ssh/sshd_config.d/allow-group.yml'
# the ssh client must belong to this group, otherwise it will be rejected
#sshd_allow_group: []
```

```yaml
sshd_conf:
- dest: '30-allow-group-sshd-client.yml'
  src: 'etc/ssh/sshd_config.d/allow-group.yml.j2'
  sshd_allow_group: [ 'sshd-client' ]
```

### `etc/ssh/sshd_config.d/authentication.yml`

```yaml title='etc/ssh/sshd_config.d/authentication.yml'
# enable public key authentication method?
sshd_pubkey_authentication: 'yes'
# enable password authentication method?
sshd_password_authentication: 'yes'
# enable keyboard-interactive authentication method?
sshd_kbd_interactive_authentication: 'no'
# use pam?
sshd_use_pam: 'yes'

# the sshd authentication method list
sshd_authentication_method: [ 'any' ]
```

```yaml
sshd_conf:
- dest: '20-pubkey-password-authentication.yml'
  src: 'etc/ssh/sshd_config.d/authentication.yml.j2'
  sshd_authentication_method: [ 'publickey,password' ]
```

### `etc/ssh/sshd_config.d/crypto-policy.yml`

```yaml title='etc/ssh/sshd_config.d/crypto-policy.yml'
# the sshd cryptography policy ('infosec.mozilla.org', 'ssh-audit.com')
sshd_crypto_policy: 'infosec.mozilla.org'
```

```yaml
sshd_conf:
- dest: '40-crypto-policy-ssh-audit.yml'
  src: 'etc/ssh/sshd_config.d/crypto-policy.yml.j2'
  sshd_crypto_policy: 'ssh-audit.com'
```

### `etc/ssh/sshd_config.d/keepalive.yml`

```yaml title='etc/ssh/sshd_config.d/keepalive.yml'
# send tcp keepalive message to the client
sshd_tcp_keep_alive: 'yes'
# the client alive interval (in seconds)
sshd_client_alive_interval: 60
# the client alive message count (0 to disable)
sshd_client_alive_count_max: 0
```

```yaml
sshd_conf:
- dest: '40-keepalive-300-3.yml'
  src: 'etc/ssh/sshd_config.d/keepalive.yml.j2'
  sshd_client_alive_interval: 300
  sshd_client_alive_count_max: 3
```

### `etc/ssh/sshd_config.d/key-revocation-list.yml`

```yaml title='etc/ssh/sshd_config.d/sshd_key-revocation-list.yml'
# the ssh key revocation list
#sshd_key_revocation_list_file: "/etc/ssh/sshd_key_revocation_list"
# the ssh key revocation list template
#sshd_key_revocation_list_template: "etc/ssh/key_revocation_list.j2"
```

```yaml
sshd_conf:
- dest: '20-key-revocation-list.yml'
  src: 'etc/ssh/sshd_config.d/key-revocation-list.yml.j2'
```

### `etc/ssh/sshd_config.d/log-level.yml`

```yaml title='etc/ssh/sshd_config.d/log-level.yml'
# the log verbosity level
sshd_log_level: 'VERBOSE'
```

```yaml
sshd_conf:
- dest: '40-log-level-verbose.yml'
  src: 'etc/ssh/sshd_config.d/log-level.yml.j2'
  sshd_log_level: 'VERBOSE'
```

### `etc/ssh/sshd_config.d/permit-root-login.yml`

```yaml title='etc/ssh/sshd_config.d/permit-root-login.yml'
# permit root login via ssh
sshd_permit_root_login: string | d('prohibit-password')
```

```yaml
sshd_conf:
- dest: '20-no-permit-root-login.yml'
  src: 'etc/ssh/sshd_config.d/no-permit-root-login.yml.j2'
  sshd_permit_root_login: 'no'
```

### `etc/ssh/sshd_config.d/print-issue.yml`

```yaml title='etc/ssh/sshd_config.d/print-issue.yml'
# the sshd issue file
sshd_issue_file: '/etc/issue.net'
# the sshd issue template
#sshd_issue_template: "etc/issue.net.j2"
```

```yaml
sshd_conf:
- dest: '40-print-issue.yml'
  src: 'etc/ssh/sshd_config.d/print-issue.yml.j2'
```

### `etc/ssh/sshd_config.d/print-lastlog.yml`

```yaml title='etc/ssh/sshd_config.d/print-lastlog.yml'
# print `lastlog` on interactive login
sshd_print_lastlog: 'yes'
```

```yaml
sshd_conf:
- dest: '40-print-lastlog.yml'
  src: 'etc/ssh/sshd_config.d/print-lastlog.yml.j2'
  sshd_print_lastlog: 'yes'
```

### `etc/ssh/sshd_config.d/print-motd.yml`

```yaml title='etc/ssh/sshd_config.d/print-motd.yml'
# print `/etc/motd` on interactive login
sshd_print_motd: 'no'
```

```yaml
sshd_conf:
- dest: '40-no-print-motd.yml'
  src: 'etc/ssh/sshd_config.d/print-motd.yml.j2'
  sshd_print_motd: 'no'
```


Example Playbook
----------------

```yaml title='Minimal'
- hosts: 'all'

  tasks:
  - ansible.builtin.include_role:
      name: 'havlasme.security.sshd'
```


License
-------

Apache-2.0


Author Information
------------------

Created by [Tomáš Havlas](https://havlas.me/).

[license-image]: https://img.shields.io/badge/license-Apache2.0-blue.svg?style=flat-square
[license-link]: ../../LICENSE
