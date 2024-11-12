autoload -Uz vcs_info

precmd() {
    vcs_info
    if [ $ITERM_SESSION_ID ]; then
        echo -ne "\033]0;${PWD##*/}\007"
    fi
}

zstyle ':vcs_info:git:*' formats ' %F{87}(%b)%f'

setopt PROMPT_SUBST
PROMPT='%F{39}%n@%m ${PWD/#$HOME/~}${vcs_info_msg_0_}%F{39}>%f
%(?.%F{green}√.%F{red}?%?)%f$ '

auto-switch-node-version() {
    local nvmrc_path="${PWD}/.nvmrc"
    if [[ -f "$nvmrc_path" ]]; then
        local current_node_version=$(nvm version)
        local requested_node_version=$(cat $nvmrc_path)

        # Find an installed Node version that satisfies the .nvmrc
        local matched_node_version=$(nvm_match_version $requested_node_version)
        if [[ ! -z "$matched_node_version" && $matched_node_version != "N/A" ]]; then
            # Switch to the matched version ONLY if necessary
            if [[ $current_node_version != $matched_node_version ]]; then
                nvm use $requested_node_version
            fi
        elif [[ $matched_node_version != "N/A" ]]; then
           echo "Node version $matched_node_version not found."
        fi
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd auto-switch-node-version
auto-switch-node-version
