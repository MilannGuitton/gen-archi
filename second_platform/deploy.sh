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
MARIADB_CLUSTER_SCRIPT="mariadb/mariadb_setup.yml"
FRONT_SCRIPT="front/front.yml"
BACK_SCRIPT="back/back.yml"
AWS_PROFILE="TRYHARD"
BASTION_IP="13.36.46.172"
SSH_HOSTS_FILE="$HOME/.ssh/known_hosts"
FRONT_CONFIG_FILE="$PWD/../app/frontend/config.js"


# Set environment variables for mariadb

ENV_FILE=".env"
# If .env file already exists, use variables from it
if [ -f "$ENV_FILE" ]; then
    source "$ENV_FILE"
else
    # Else set defaults
    export MARIADB_USER="tryhard"
    export MARIADB_PASSWORD="1234"
    export MARIADB_HOST="p2-database.aws.tryhard.fr"
    export MARIADB_PORT="80"
    export MARIADB_DATABASE="mariondb"
    echo "MARIADB_USER=$MARIADB_USER" > "$ENV_FILE"
    echo "MARIADB_PASSWORD=$MARIADB_PASSWORD" >> "$ENV_FILE"
    echo "MARIADB_DATABASE=$MARIADB_DATABASE" >> "$ENV_FILE"
    echo "MARIADB_HOST=p2-database.aws.tryhard.fr" >> "$ENV_FILE"
    echo "MARIADB_PORT=80" >> "$ENV_FILE"
fi

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

    ansible-playbook "$MARIADB_CLUSTER_SCRIPT"
    echo 'export const ENDPOINT = "https://p2-backend.aws.tryhard.fr";' > "$FRONT_CONFIG_FILE"
    ansible-playbook "$FRONT_SCRIPT"
    ansible-playbook "$BACK_SCRIPT"
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