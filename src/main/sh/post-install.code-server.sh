#!/bin/sh

DEBUG=true

POST_INSTALL="upgradeCodeServer installGit installGitFlow installDockerEngine"
POST_INSTALL_QUICK="upgradeCodeServer installDockerWrapper"

GIT_USER=user
GIT_EMAIL=user@gitlab.com

#################################################################################
## Code Server post-installer script                                           ##
##                                                                             ##
##                                                                             ##
##   CODENAME:   ldt-vscode                                                    ##
##                                                                             ##
##   @author:    LDworks                                                       ##
##   @version:   1.0.0.202405151235                                            ##
##                                                                             ##
#################################################################################

main() {
    log "DEBUG" "code-server -- post-install..."
    cmds=$POST_INSTALL

    if [ "$1" = "--quick" ]; then cmds=$POST_INSTALL_QUICK; fi

    for cmd in $cmds; do
        log "DEBUG" "code-server -- -- run cmd: '$cmd'"
        eval $cmd
    done
}

#################################################################################
## Prints a formatted message to stdout

log() {
    logLevel=$1
    logMessage=$2

    now=$(date +"%Y-%m-%d %H:%M:%S.%3N")

    if [ $logLevel = "DEBUG" ]; then
        if [ "$DEBUG" = "true" ]; then
            printf "$now [$logLevel] %s\n" "$logMessage"
        fi
    else
        printf "$now [$logLevel] %s\n" "$logMessage"
    fi
}

#################################################################################
## Upgrade OS of the composed vscode server

upgradeCodeServer() {
    me=$(whoami)
    res=/config/common/res

    sudo apt update
    sudo apt upgrade -y
    sudo apt install -y build-essential net-tools curl htop mc nano

    sudo chown -Rv $me:$me /config/
    sudo chown -Rv $me:$me /works/

    if [ -f "$res/gradle.properties" ]; then
        cp -vf $res/gradle.properties /config/gradle.properties
    fi
    if [ -f "$res/keybindings.json" ]; then
        cp -vf $res/keybindings.json /config/data/User/keybindings.json
    fi
    if [ -f "$res/settings.json" ]; then
        cp -vf $res/settings.json /config/data/User/settings.json
    fi
    sudo apt autoremove -y
}

#################################################################################
## Install Git with latest released version

installGit() {
    gitUser=$GIT_USER
    gitEmail=$GIT_EMAIL

    sudo apt update
    sudo apt install -y git

    git config --global user.name $gitUser
    git config --global user.email $gitEmail
    git config --global credential.helper "cache --timeout=-1"
    git config --global init.defaultBranch master

    sudo apt autoremove -y
}

#################################################################################
## Install Git-Flow with latest released version

installGitFlow() {
    sudo apt update
    sudo apt install -y git-flow
    sudo apt autoremove -y
}

#################################################################################
## Install Docker Engine with latest released version

installDockerEngine() {
    me=$(whoami)
    res=/config/common/res

    curl -sL "https://get.docker.com" | /bin/sh

    sudo adduser $me sudo
    sudo adduser $me docker

    installDockerWrapper

    sudo apt autoremove -y
}

#################################################################################
## Install Docker-Wrapper

installDockerWrapper() {
    if [ -f "$res/dockerw.sh" ]; then
        cp -vf $res/dockerw.sh /config/dockerw
        sudo chown -v $me:$me /config/dockerw
        sudo chmod -v 755 /config/dockerw
    fi

    if [ ! -f "/config/.bash_aliases" ]; then
        touch -v /config/.bash_aliases
        sudo chown -v $me:$me /config/.bash_aliases
    fi

    if [ "$(cat /config/.bash_aliases | grep dockerw)" = "" ]; then
        echo "alias dockerw=\"/bin/bash /config/dockerw\"" >>/config/.bash_aliases
    fi
}

#################################################################################
## Install Docker-Compose with latest released version

installDockerCompose() {
    sudo apt update
    sudo apt-get install -y docker-compose
    sudo apt autoremove -y
}

#################################################################################
## Install JDK with given java version

installJDK() {
    javaVersion=$JAVA_VERSION
    sudo apt update
    sudo apt install -y $javaVersion
    sudo apt autoremove -y
}

#################################################################################
## Install NodeJS with given node version

installNodeJS() {
    nodeVersion=$NODE_VERSION
    sudo apt update
    sudo apt install ca-certificates curl gnupg
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/$nodeVersion.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
    sudo apt update
    sudo apt install nodejs
    sudo apt autoremove -y
}

#################################################################################
## USAGE:
##      post-install.code-server
##
## environment:
##      PASSWORD            -    strong password for code-server auth
##      SUDO_PASSWORD       -    strong password for code-server sudo user
##      PUID                -    owner user of the code-server instance
##      PGID                -    owner group of the code-server instance
##      GIT_USER            -    username for git global config (username)
##      GIT_EMAIL           -    email for git global config (username@git-scm.com)
##      POST_INSTALL        -    post-install tasks to run
##      JAVA_VERSION        -    java version (openjdk-default-jdk)
##      NODE_VERSION        -    nodejs version (node_lts)
##
####

main $*
