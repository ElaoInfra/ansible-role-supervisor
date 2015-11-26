<img src="http://www.elao.com/images/corpo/logo_red_small.png"/>

[![Ansible Role](https://img.shields.io/ansible/role/5564.svg?style=plastic)](https://galaxy.ansible.com/list#/roles/5564) [![Platforms](https://img.shields.io/badge/platforms-debian-lightgrey.svg?style=plastic)](#) [![License](http://img.shields.io/:license-mit-lightgrey.svg?style=plastic)](#)

# Ansible Role: Supervisor

This role will assume the setup of Supervisor

It's part of the ELAO <a href="http://www.manalas.com" target="_blank">Ansible stack</a> but can be used as a stand alone component.

## Requirements

- Ansible 1.9.0+

## Dependencies

- Pip

## Installation

Using ansible galaxy:

```bash
ansible-galaxy install elao.supervisor,1.0
```
You can add this role as a dependency for other roles by adding the role to the meta/main.yml file of your own role:

```yaml
dependencies:
  - { role: elao.supervisor }
```

## Role Handlers

|Name              | Type    | Description                |
|------------------| ------- | -------------------------- |
|supervisor restart| Service | Restart supervisor service |

## Role Variables

| Name                              | Default               | Type    | Description                                     |
|--------------------------------   | --------------------- | ------- | ----------------------------------------------- |
| elao_supervisor_config_file       | /etc/supervisord.conf | String  | Path to supervisor configuration file           |
| elao_supervisor_config_template   | ~                     | String  | Template used for supervisor configuration file |
| elao_supervisor_config            | {}                    | Array   | Supervisor configuration options                |
| elao_supervisor_configs           | []                    | Array   | Configs                                         |
| elao_supervisor_configs           | []                    | Array   | Configs                                         |
| elao_supervisor_configs_exclusive | false                 | Boolean | Exclusion of existings files                    |
| elao_supervisor_configs_dir       | /etc/supervisor.d     | String  | Path to supervisor configuration directory      |
| elao_supervisor_configs_template  | configs/empty.conf.j2 | String  | Template to use for service definition          |
| elao_supervisor_configs           | []                    | Array   | Collection of service configuration             |
| elao_supervisor_log_dir           | /var/log/supervisor   | String  | Path to supervisor log file                     |



### Configuration example

```yaml
elao_supervisor_config:
  loglevel: info
```

Enable http server

```yaml
elao_supervisor_configs:
  - file:     inet_http_server.conf
    template: configs/inet_http_server_default.conf.j2
    config:
      port:     "*:9001"
```

Program

```yaml
elao_supervisor_configs:
  - file:     foo.conf
    template: configs/program_default.conf.j2
    config:
      name: foo
      command: "bar"
```

## Example playbook

    - hosts: servers
      roles:
         - { role: elao.supervisor }

# Licence

MIT

# Author information

ELAO [**(http://www.elao.com/)**](http://www.elao.com)
