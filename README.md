[![Build Status](https://travis-ci.org/cdelgehier/ansible-role-memcached.svg?branch=master)](https://travis-ci.org/cdelgehier/ansible-role-memcached)
# Ansible role `memcached`

An Ansible role for PURPOSE. Specifically, the responsibilities of this role are to:

- install a memcached
- configure a memcached

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_memcached_namespace` | `"OPENIO" ` | Namespace OpenIO SDS |
| `openio_memcached_serviceid` | `"0"` | Service ID | 

## Dependencies

```yaml
---
- src: https://github.com/racciari/ansible-role-repo-openio-sds
  version: master
  name: repository

- src: https://github.com/open-io/ansible-role-openio-gridinit.git
  version: master
  name: gridinit
...
```

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: repository
    - role: gridinit
      openio_gridinit_services:
        - name: memcached-0
          namespace: "OIO"
          type: memcached
          configuration:
            command: >-
              /usr/bin/memcached -m 64 -p 12346
              -u openio -l {{ ansible_default_ipv4.address }} -c 1024 -U 0
            enabled: true
            start_at_boot: true
            on_die: respawn
            uid: openio
            gid: openio
            env_PATH: /usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
    - role: role_under_test
      openio_memcached_namespace: "OIO"
```


```ini
[memcached]
node1 ansible_host=192.168.1.173
```

## Contributing

Issues, feature requests, ideas are appreciated and can be posted in the Issues section.

Pull requests are also very welcome. The best way to submit a PR is by first creating a fork of this Github project, then creating a topic branch for the suggested change and pushing that branch to your own fork. Github can then easily create a PR based on that branch.

## License

Apache License, Version 2.0

## Contributors

- [Cedric DELGEHIER](https://github.com/cdelgehier/) (maintainer)
