# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo " ("${ref#refs/heads/}")"
}

# User specific aliases and functions
PS1="\[\e[1;34m\]\u@\h$NC \w\[\033[0;36m\]\$(parse_git_branch)\[\e[1;34m\]>\[\e[0m\]\n$ \[\033]0;\u@\h \w\007\]"

# mac aliases
alias ll="ls -oAFG"
alias l="ls -oFG"
