# vscode-common

## post-install

```sh
/bin/sh /config/common/bin/post-install.code-server.sh
```

```sh
/bin/sh /config/common/bin/post-install.code-server.sh --quick
```

## default list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer
```

## full list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer installGit installGitFlow installDockerEngine installDockerCompose installJDK installNodeJS
GIT_USER=username
GIT_EMAIL=username@git-scm.com
JAVA_VERSION=openjdk-default
NODE_VERSION=node_lts
```

## git list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer installGit installGitFlow
GIT_USER=username
GIT_EMAIL=username@git-scm.com
```

## docker list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer installDockerEngine installDockerCompose
```

## jdk list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer installGit installGitFlow installDockerEngine installDockerCompose installJDK
GIT_USER=username
GIT_EMAIL=username@git-scm.com
JAVA_VERSION=openjdk-default
```

## node list

```list
PASSWORD=code-server_P4ssWd+
SUDO_PASSWORD=code-server_sUd0P4ssWd+
PUID=1000
PGID=1000
POST_INSTALL=upgradeCodeServer installGit installGitFlow installDockerEngine installDockerCompose installNodeJS
GIT_USER=username
GIT_EMAIL=username@git-scm.com
NODE_VERSION=node_lts
```
