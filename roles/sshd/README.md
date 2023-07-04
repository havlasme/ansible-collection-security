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
  ## allow client to set the locale environment variables
  - dest: "60_accept_env_locale_only.conf"
    src: "sshd_config.d/accept_env.conf.j2"
    sshd_accept_key: "LANG LC_*"

# the sshd moduli file
sshd_moduli_file: "/etc/ssh/moduli"
# the sshd moduli minimal length
sshd_moduli_minimum: 3071
```

### `accept_env.yml`

```yaml title="accept_env.yml"
# allow client to set the environment variables
#sshd_accept_env: ""
```

### `allow_group.yml`

```yaml title="allow_group.yml"
#sshd_allow_group: []
```

### `authentication.yml`

```yaml title="authentication.yml"

```

### `crypto_policy.yml`

```yaml title="crypto_policy.yml"
# the sshd cryptography policy ('ssh-audit.com', 'infosec.mozilla.org')
sshd_crypto_policy: "infosec.mozilla.org"
```

### `log_level.yml`

```yaml title="log_level.yml
# log verbosity level
sshd_log_level: 'VERBOSE'
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
