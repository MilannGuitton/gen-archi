# GEN-ARCHI

The goal of this project is to implement and automatically deploy  Second and Third platfoms ([IDC](https://en.wikipedia.org/wiki/Third_platform)).

## Second platform

This infratructure is deployed using [Terraform for AWS](https://registry.terraform.io/providers/hashicorp/aws/latest) and its configuration is done using [Ansible](https://docs.ansible.com/)

At the root of the `second_platform` directory is a script to automate the deployment of the infrastructure. Possible options are documented here:
```bash
bash deploy.sh -h
```