havlasme.security.sshd
======================

[![Apache-2.0 license][license-image]][license-link]

An [Ansible](https://www.ansible.com/) role to install and configure sshd.


Requirements
------------

None.


Role Variables
--------------

```yaml
# the sshd package state ('present', 'latest')
sshd_state: "present"
# should start the sshd service at boot
sshd_enabled: "yes"
# can ansible restart the sshd service
sshd_ansible_restart: "yes"

# the sshd port
sshd_port: [ "22" ]
# the sshd listen
#sshd_listen: [ "0.0.0.0" ]
# the ssh host key type
#sshd_host_key_type: [ "ed25519", "rsa", "ecdsa" ]

# the sshd conf file
sshd_conf_file: "/etc/ssh/sshd_config"
# the sshd conf template
sshd_conf_template: "sshd_config.j2"
# the sshd conf-d directory
sshd_conf_d: "/etc/ssh/sshd_config.d"
# the sshd conf-d file list
sshd_conf_d_file:
## basic password / pubkey authentication
- dest: "20_password_authentication.conf"
  src: "sshd_config.d/authentication.conf.j2"
## accept env sent by the ssh client
- dest: "40_accept_env_locale_only.conf"
  src: "sshd_config.d/accept_env.conf.j2"
  sshd_accept_key: "LANG LC_*"

# the sshd moduli file
sshd_moduli_file: "/etc/ssh/moduli"
# the sshd moduli minimal length
#sshd_moduli_minimum: 3071
```

### `accept_env.yml`

```yaml title="accept_env.yml"
# accept env sent by the ssh client
sshd_accept_env: "no"
```

```yaml
sshd_conf_d_file:
- dest: "40_accept_env_locale_only.yml"
  src: "sshd_config.d/accept_env.yml.j2"
  sshd_accept_env: "LANG LC_*"
```

### `allow_group.yml`

```yaml title="allow_group.yml"
# the ssh client must belong to this group, otherwise it will be rejected
#sshd_allow_group: []
```

```yaml
sshd_conf_d_file:
- dest: "30_allow_group_sshd_client.yml"
  src: "sshd_config.d/allow_group.yml.j2"
  sshd_allow_group: [ "sshd_client" ]
```

### `authentication.yml`

```yaml title="authentication.yml"
# enable public key authentication method?
sshd_pubkey_authentication: "yes"
# enable password authentication method?
sshd_password_authentication: "yes"
# enable keyboard-interactive authentication method?
sshd_kbd_interactive_authentication: "no"
# use pam?
sshd_use_pam: "yes"

# the sshd authentication method list
sshd_authentication_method: ["any"]
```

```yaml
sshd_conf_d_file:
- dest: "20_pubkey_password_authentication.yml"
  src: "sshd_config.d/authentication.yml.j2"
  sshd_authentication_method: [ "publickey,password" ]
```

### `crypto_policy.yml`

```yaml title="crypto_policy.yml"
# the sshd cryptography policy ('infosec.mozilla.org', 'ssh-audit.com')
sshd_crypto_policy: "infosec.mozilla.org"
```

```yaml
sshd_conf_d_file:
- dest: "40_crypto_policy_ssh_audit.yml"
  src: "sshd_config.d/crypto_policy.yml.j2"
  sshd_crypto_policy: "ssh-audit.com"
```

### `keepalive.yml`

```yaml title="keepalive.yml"
# send tcp keepalive message to the client
sshd_tcp_keep_alive: "yes"
# the client alive interval (in seconds)
sshd_client_alive_interval: 300
# the client alive message count (0 to disable)
sshd_client_alive_count_max: 0
```

```yaml
sshd_conf_d_file:
- dest: "40_keepalive_300_3.yml"
  src: "sshd_config.d/keepalive.yml.j2"
  sshd_client_alive_interval: 300
  sshd_client_alive_count_max: 3
```

### `key_revocation_list.yml`

```yaml title="sshd_key_revocation_list.yml"
# the ssh key revocation list
#sshd_key_revocation_list_file: "/etc/ssh/sshd_key_revocation_list"
```

```yaml
sshd_conf_d_file:
- dest: "20_key_revocation_list.yml"
  src: "sshd_config.d/key_revocation_list.yml.j2"
```

### `log_level.yml`

```yaml title="log_level.yml
# the log verbosity level
sshd_log_level: "VERBOSE"
```

```yaml
sshd_conf_d_file:
- dest: "40_log_level_verbose.yml"
  src: "sshd_config.d/log_level.yml.j2"
  sshd_log_level: "VERBOSE"
```

### `permit_root_login.yml`

```yaml title="permit_root_login.yml"
# permit root login via ssh
sshd_permit_root_login: "no"
```

```yaml
sshd_conf_d_file:
- dest: "20_permit_root_login.yml"
  src: "sshd_config.d/no_permit_root_login.yml.j2"
  sshd_permit_root_login: "no"
```

### `print_issue.yml`

```yaml title="print_issue.yml"
# the sshd issue file
sshd_issue_file: "/etc/issue.net"
# the sshd issue template
#sshd_issue_template: "issue.net.j2"
```

```yaml
sshd_conf_d_file:
- dest: "40_print_issue.yml"
  src: "sshd_config.d/print_issue.yml.j2"
```

### `print_lastlog.yml`

```yaml title="print_lastlog.yml"
# print `lastlog` on interactive login
sshd_print_lastlog: "yes"
```

```yaml
sshd_conf_d_file:
- dest: "40_print_lastlog.yml"
  src: "sshd_config.d/print_lastlog.yml.j2"
  sshd_print_lastlog: "yes"
```

### `print_motd.yml`

```yaml title="print_motd.yml"
# print `/etc/motd` on interactive login
sshd_print_motd: "no"
```

```yaml
sshd_conf_d_file:
- dest: "40_print_motd.yml"
  src: "sshd_config.d/no_print_motd.yml.j2"
  sshd_print_motd: "no"
```


Dependencies
------------

None.


Example Playbook
----------------

```yaml
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
