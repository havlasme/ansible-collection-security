havlasme.security.sshd
======================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure [SSHd](https://www.openssh.com/) service on [Debian](https://www.debian.org/) or [Ubuntu](https://www.ubuntu.com/).

* Install or Update Package via APT
* (Optional) Delete Small Moduli
* (Optional) Create or Update Key Revocation List
* (Optional) Create or Update `issue` File
* Create, Update, or Delete Configuration File
* Start and Enable Service

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

# the sshd port
sshd_port: [ '22' ]
# the sshd listen ip
#sshd_listen: [ '0.0.0.0' ]
# the ssh host key type
#sshd_host_key_type: [ 'ed25519', 'rsa', 'ecdsa' ]

# the sshd conf list
## - dest: string
##   tmpl: string | d(sshd_conf_template)
##   state: enum('present', 'absent') | d('present')
sshd_conf:
- dest: 'sshd_config'
  tmpl: 'etc/ssh/sshd_config.j2'
## basic password or pubkey authentication
- dest: 'sshd_config.d/20_password-authentication.conf'
  tmpl: 'etc/ssh/sshd_config.d/authentication.conf.j2'
## allow client to set the locale environment variables
- dest: 'sshd_config.d/40_accept-env-locale-only.conf'
  tmpl: 'etc/ssh/sshd_config.d/accept-env.conf.j2'
  sshd_accept_env: 'LANG LC_*'
# the sshd conf.d default template
sshd_conf_template: 'etc/ssh/sshd_config.d/__copy__.conf.j2'
# the sshd conf.d directory
sshd_conf_d: '/etc/ssh'

# the sshd moduli file
sshd_moduli_file: '/etc/ssh/moduli'
# the sshd moduli minimal size
#sshd_moduli_minsize: 3071
```

### `etc/ssh/sshd_config.d/accept-env.yml`

```yaml title='etc/ssh/sshd_config.d/accept-env.yml'
# accept listed env sent by the ssh client
sshd_accept_env: string | d('no')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_accept-env-locale-only.yml'
  src: 'etc/ssh/sshd_config.d/accept-env.yml.j2'
  sshd_accept_env: 'LANG LC_*'
```

### `etc/ssh/sshd_config.d/allow-group.yml`

```yaml title='etc/ssh/sshd_config.d/allow-group.yml'
# the ssh client must belong to at least one of these groups
sshd_allow_group: string[]
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/30_allow-group-sshd-client.yml'
  src: 'etc/ssh/sshd_config.d/allow-group.yml.j2'
  sshd_allow_group: [ 'sshd-client' ]
```

### `etc/ssh/sshd_config.d/authentication.yml`

```yaml title='etc/ssh/sshd_config.d/authentication.yml'
# enable public key authentication method?
sshd_pubkey_authentication: boolean | d('yes')
# enable password authentication method?
sshd_password_authentication: boolean | d('yes')
# enable keyboard-interactive authentication method?
sshd_kbd_interactive_authentication: boolean | d('no')
# use linux pam?
sshd_use_pam: boolean | d('yes')

# the sshd authentication method list
sshd_authentication_method: string[] | d(['any'])
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/20_pubkey-password-authentication.yml'
  src: 'etc/ssh/sshd_config.d/authentication.yml.j2'
  sshd_authentication_method: [ 'publickey,password' ]
```

### `etc/ssh/sshd_config.d/crypto-policy.yml`

```yaml title='etc/ssh/sshd_config.d/crypto-policy.yml'
# the sshd cryptography policy ('infosec.mozilla.org', 'ssh-audit.com')
sshd_crypto_policy: enum('infosec.mozilla.org', 'ssh-audit.com') | d('infosec.mozilla.org')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_crypto-policy-ssh-audit.yml'
  src: 'etc/ssh/sshd_config.d/crypto-policy.yml.j2'
  sshd_crypto_policy: 'ssh-audit.com'
```

### `etc/ssh/sshd_config.d/keepalive.yml`

```yaml title='etc/ssh/sshd_config.d/keepalive.yml'
# send tcp keepalive message to the client
sshd_tcp_keep_alive: boolean | d('yes')
# the client alive interval (in seconds)
sshd_client_alive_interval: int | d(60)
# the client alive message count (0 to disable)
sshd_client_alive_count_max: int | d(0)
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_keepalive-300-3.yml'
  src: 'etc/ssh/sshd_config.d/keepalive.yml.j2'
  sshd_client_alive_interval: 300
  sshd_client_alive_count_max: 3
```

### `etc/ssh/sshd_config.d/key-revocation-list.yml`

```yaml title='etc/ssh/sshd_config.d/sshd_key-revocation-list.yml'
# the ssh key revocation list
sshd_key_revocation_list_file: string
# the ssh key revocation list template
sshd_key_revocation_list_template: string | d(omit)
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/20_key-revocation-list.yml'
  src: 'etc/ssh/sshd_config.d/key-revocation-list.yml.j2'
```

### `etc/ssh/sshd_config.d/log-level.yml`

```yaml title='etc/ssh/sshd_config.d/log-level.yml'
# the log verbosity level
sshd_log_level: string | d('VERBOSE')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_log-level-verbose.yml'
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
- dest: 'sshd_config.d/20_no-permit-root-login.yml'
  src: 'etc/ssh/sshd_config.d/no-permit-root-login.yml.j2'
  sshd_permit_root_login: 'no'
```

### `etc/ssh/sshd_config.d/print-issue.yml`

```yaml title='etc/ssh/sshd_config.d/print-issue.yml'
# the sshd issue file
sshd_issue_file: string | d('/etc/issue.net')
# the sshd issue template
sshd_issue_template: string | d('etc/issue.net.j2')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_print-issue.yml'
  src: 'etc/ssh/sshd_config.d/print-issue.yml.j2'
```

### `etc/ssh/sshd_config.d/print-lastlog.yml`

```yaml title='etc/ssh/sshd_config.d/print-lastlog.yml'
# print `lastlog` on interactive login
sshd_print_lastlog: boolean | d('yes')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_print-lastlog.yml'
  src: 'etc/ssh/sshd_config.d/print-lastlog.yml.j2'
  sshd_print_lastlog: 'yes'
```

### `etc/ssh/sshd_config.d/print-motd.yml`

```yaml title='etc/ssh/sshd_config.d/print-motd.yml'
# print `/etc/motd` on interactive login
sshd_print_motd: boolean | d('no')
```

```yaml
sshd_conf:
- dest: 'sshd_config.d/40_no-print-motd.yml'
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
