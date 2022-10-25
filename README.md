# GEN-ARCHI

The goal of this project is to implement and automatically deploy  Second and Third platfoms (IDC).

## Terrraform

You will need to be in the `terraform/` directory of the platform you want to deploy.

The tfstate file is in a shared S3 bucket. To use it, you first need to set your AWS profile to the one of the TryHard organisation. For example:

```bash
export AWS_PROFILE="TRYHARD"
```

You can then retrieve the state by running:

```bash
terraform init
```


```bash
terraform apply
```

## MariaDB

To setup a setup a database on the remote VM, you need to run the ansible role. To do this, go to the `second_platform/ansible/mariadb` directory and run:

```bash
ansible-playbook mariadb_setup.yml
```