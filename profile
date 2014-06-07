# path設定
export PATH="$PATH":/C/tools/vim

# lsで日本語を表示する
alias ls='ls --color=auto --show-control-chars'
alias ll='ls -l'
alias l='ls -CF'

# gettext用
export OUTPUT_CHARSET=sjis

# git path
alias git="/C/tools/Git/bin/git.exe"

# ロケール他
export TZ="JST-9"
export LANG="C"
export LC_ALL="C"
export TPUT_COLORS=256
export HOSTNAME=msys-bash
export PS1="[\u@\[\033[00;32m\]$HOSTNAME\[\033[0m\] \t \W]$ "
