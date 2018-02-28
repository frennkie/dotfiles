### Script for installing **tmux** where you don't have root access

It is assumed that standard compilation tools (a C/C++ compiler with autoconf) are available.

This script fetches and compiles the latest version of [**tmux**](https://github.com/tmux/tmux) from github, with its dependencies [**libevent**](https://github.com/libevent/libevent) and [**ncurses**](https://ftp.gnu.org/pub/gnu/ncurses/).


export http_proxy
export https_proxy
export ftp_proxy

sudo apt-get install make autoconf m4 libtool pkg-config


One-line install:

```bash
bash install_tmux.sh
```

The latest version of tmux will be installed in `$HOME/local/bin/tmux`.
