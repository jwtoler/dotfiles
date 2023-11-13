#!/bin/sh

WORK_PROJECTS="$HOME/Projects/work"

create_docker_network() {
    echo -ne "[DOCKER NETWORK] Checking for $1..."
    if docker network inspect $1 &>/dev/null; then
        echo -ne "already exists"           
    else
        docker network create $1 && echo -ne "created"  
    fi
}

create_docker_volume() {
    echo -ne "[DOCKER VOLUME] Checking for $1..."
    if docker volume inspect $1 &>/dev/null; then
        echo -ne "already exists"
    else
        docker volume create $1 && echo -ne "created"
    fi
}

configure_local_dns() {
    echo -ne "[DNS] Configuring local .test DNS..."
    if [[ -f "/etc/resolver/test" ]]; then
        echo -ne "already configured"
    else
        # Make /etc/resolver directory
        sudo mkdir -p /etc/resolver

        # Add local resolver for .test tld
        echo -e "nameserver 127.0.0.1 \nport 5053" | sudo tee /etc/resolver/test &>/dev/null
        echo -ne "configured"
        fi
    }

open -g -a Docker

create_docker_network shared
create_docker_volume bundles
configure_local_dns

if [[ -f "$WORK_PROJECTS/docker-base/.git" ]]; then
    git pull &>/dev/null
else
    mkdir -p "$WORK_PROJECTS" 
    git clone git@git.charlotte.edu:its-appdev/docker-base.git "$WORK_PROJECTS/docker-base" &>/dev/null
fi

cd "$WORK_PROJECTS/docker-base" && mutagen-compose up -d

echo -ne "Dev environment has been configured! Access projects using 'app-name'.dev.test"
echo -ne "Work directory is stored at: $WORK_PROJECTS"