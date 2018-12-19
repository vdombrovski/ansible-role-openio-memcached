[![Build Status](https://travis-ci.org/open-io/ansible-role-openio-memcached.svg?branch=master)](https://travis-ci.org/open-io/ansible-role-openio-memcached)
# Ansible role `memcached`

An Ansible role for manage memcached. Specifically, the responsibilities of this role are to:

- install a memcached
- configure a memcached

## Requirements

- Ansible 2.4+

## Role Variables


| Variable   | Default | Comments (type)  |
| :---       | :---    | :---             |
| `openio_memcached_bind_interface` | `{{ ansible_default_ipv4.alias }}` | Listening interface |
| `openio_memcached_bind_address` | `{{ hostvars[inventory_hostname]['ansible_' + openio_memcached_bind_interface]['ipv4']['address'] }}` | Listening IP address |
| `openio_memcached_bind_port` | `6019` | Listening PORT |
| `openio_memcached_cachesize_MBytes` | `64` | Cap of 64 megs of memory |
| `openio_memcached_gridinit_dir` | `/etc/gridinit.d/{{ openio_memcached_namespace }}` | Path to copy the gridinit conf |
| `openio_memcached_gridinit_file_prefix` | `""` | Maybe set it to {{ openio_memcached_namespace }}- for old gridinit's style |
| `openio_memcached_gridinit_on_die` | `respawn` | Behaviour on failure |
| `openio_memcached_gridinit_start_at_boot` | `true` | Start at system boot |
| `openio_memcached_maxconn` | 1024 |  Limit the number of simultaneous incoming connections |
| `openio_memcached_namespace` | `"OPENIO" ` | Namespace OpenIO SDS |
| `openio_memcached_serviceid` | `"0"` | Service ID |

## Dependencies

- You have to use this role after the role `ansible-role-openio-repository` and the role `ansible-role-openio-gridinit`

```yaml
---
- src: https://github.com/open-io/ansible-role-repo-openio-users
  version: master
  name: users

- src: https://github.com/open-io/ansible-role-repo-openio-sds
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
    - role: users
    - role: repository
    - role: gridinit
    - role: role_under_test
      openio_memcached_namespace: "OIO"
      openio_memcached_bind_address: "{{ ansible_default_ipv4.address }}"
      openio_memcached_bind_port: "12346"

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
