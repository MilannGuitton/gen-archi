# GEN-ARCHI

The goal of this project is to implement and automatically deploy  Second and Third platfoms ([IDC](https://en.wikipedia.org/wiki/Third_platform)).

## Second platform

This infratructure is deployed using [Terraform for AWS](https://registry.terraform.io/providers/hashicorp/aws/latest) and its configuration is done using [Ansible](https://docs.ansible.com/)

At the root of the `second_platform` directory is a script to automate the deployment of the infrastructure. Possible options are documented here:
```bash
bash deploy.sh -h
```

By default, the database is created with some credentials in order to avoid crashes during deployment. To change this configuration, you can create a `.env` file at the root of the `second_platform` directory with the following format:

```bash
#!/bin/sh
export MARIADB_USER=tryhard #  The MariaDB username.
export MARIADB_PASSWORD=1234 # The password for the user.
export MARIADB_HOST=database.p2.aws.tryhard.fr # The endpoint associated with the database.
export MARIADB_DATABASE=mariondb # The name of the database.
export MARIADB_PORT=80 # The port associated with the database.
```

Default values are the ones specified in the example above.

## Third platform

The entirery of the infrastructure is deployed using [Terraform](https://registry.terraform.io/providers/hashicorp/aws/latest). It is composed of two parts, frontend and backend. All the code for the third platform is in the corresponding `third_platform` folder.

To deploy it, you must first be in the folder mentionned above. From here, go in the `frontend` and `backend` folders and run:

```bash
terraform init
terraform apply
```

