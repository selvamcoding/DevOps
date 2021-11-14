

### Ansible Playbook run command,

```shell
ansible-playbook -i <IP Addresses>, <Dir>/<yamlfile> -e "ansible_user=<ansible_user>"
```

E.g:
```shell
ansible-playbook -i 192.168.1.111, postgres/postgres.yml -e "ansible_user=root"
```
