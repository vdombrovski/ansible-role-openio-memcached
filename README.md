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
| `memcached_enabled_in_systemd` | `true` | Set `enabled` in systemd |
| `memcached_port` | `11211` | listening port |
| `memcached_maxconn` | `1024` | By default the max number of concurrent connections is set to 1024. Configuring this correctly is important. Extra connections to memcached may hang while waiting for slots to free up. You may detect if your instance has been running out of connections by issuing a `stats` command and looking at `listen_disabled_num`. That value should be zero or close to zero. |
| `memcached_cachesize_MBytes` | `64` | Start with a cap of 64 megs of memory |
| `memcached_bind_interface` | `eth0` | Interface used  |
| `memcached_bind_address` | `"{{ hostvars[inventory_hostname]['ansible_' + memcached_bind_interface]['ipv4']['address'] }}"` | IP used for address |
| `memcached_log_file` | `/var/log/memcached.log` | The log file |
| `memcached_log_verbose` | `"` | The verbosity `-v` or `-vv` improve it |
| `memcached_udp_disabled` | `true` | Disable UDP to prevent reflection attacks |


## Dependencies

None

## Example Playbook

```yaml
- hosts: memcached
  gather_facts: true
  become: true
  roles:
    - role: ansible-role-memcached
      memcached_bind_address: 192.168.1.173
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
