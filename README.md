# GEN-ARCHI

The goal of this project is to implement and automatically deploy  Second and Third platfoms (IDC).

## Terrraform

To deploy the infrastructure, go to the `terraform/` directory of the desired platform you want to deploy and run:

```bash
terraform apply
```

## MariaDB

To setup a setup a database on the remote VM, you need to run the ansible role. To do this, go to the `second_platform/ansible` directory and run:

```bash
ansible-playbook -i hosts.yml mariadb_setup/tests/test.yml
```