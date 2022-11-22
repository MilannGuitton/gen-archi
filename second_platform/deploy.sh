#!/bin/sh

################################################################################
###                                  HELP                                    ###
################################################################################

print_help() {
    echo "Usage: $0 [OPTION]..."
    echo ""
    echo "  -h, --help                  display this help and exit"
    echo "  -t, --terraform             run terraform script only"
    echo "  -a, --ansible               run ansible script only"
    echo "  -d, --destroy               destroy the terraform infrastructure"
    echo "  -p, --profile [PROFILE]     use AWS profile, and deploy all. Default is \"TRYHARD\""
}


################################################################################
###                                  SETUP                                   ###
################################################################################

TERRAFORM_FOLDER="terraform"
ANSIBLE_FOLDER="ansible"
MARIADB_SETUP_SCRIPT="mariadb/mariadb_setup.yml"
BACKUP_SCRIPT="backup/backup.yml"
AWS_PROFILE="TRYHARD"
BASTION_IP="35.181.111.83"
SSH_HOSTS_FILE="$HOME/.ssh/known_hosts"


################################################################################
###                                 CREATE                                   ###
################################################################################

deploy_terraform() {
    cd $TERRAFORM_FOLDER
    terraform init
    terraform apply -auto-approve
    cd ..
}

run_ansible() {
    cd "$ANSIBLE_FOLDER"
    keyscan=`ssh-keyscan -H $BASTION_IP`
    if [ -z "$keyscan" ]; then
        echo "Keyscan failed"
        exit 1
    fi
    echo "$keyscan" >> "$SSH_HOSTS_FILE"
    ansible-playbook "$MARIADB_SETUP_SCRIPT"
    ansible-playbook "$BACKUP_SCRIPT"
    cd ..
}


################################################################################
###                                 DESTROY                                  ###
################################################################################

destroy_infra() {
    cd "$TERRAFORM_FOLDER"
    terraform destroy -auto-approve
}


################################################################################
###                                  MAIN                                    ###
################################################################################

export AWS_PROFILE="$AWS_PROFILE"

if [ -z "$1" ]; then
    deploy_terraform
    run_ansible
elif [ "$1" = "--terraform" ] || [ "$1" = "-t" ]; then
    deploy_terraform
elif [ "$1" = "--ansible" ] || [ "$1" = "-a" ]; then
    run_ansible
elif [ "$1" = "--destroy" ] || [ "$1" = "-d" ]; then
    destroy_infra
elif [ "$1" = "--profile" ] || [ "$1" = "-p" ]; then
    if [ -z "$2" ]; then
        echo "No profile specified"
        exit 1
    fi
    AWS_PROFILE="$2"
    deploy_terraform
    run_ansible
else
    if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
        print_help
    else
        echo "Invalid option: $1"
        print_help
    fi
fi