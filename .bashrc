[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[[ -r "/usr/local/etc/bash_completion.d/git-completion.bash" ]] && . "/usr/local/etc/bash_completion.d/git-completion.bash"

export PS1="\[\e[36;1m\]\w \[\e[32m\]\$(git rev-parse --abbrev-ref HEAD 2> /dev/null)\[\e[33m\]\$ \[\e[0m\]"
export RUST_BACKTRACE=1

# Git aliases

alias g='git'

alias gfa='git fetch --all'
alias gps='gfa && git push origin $(git rev-parse --abbrev-ref HEAD 2> /dev/null)'
alias gpsf='gps --force'
alias gpl='gfa && git merge --ff-only origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null)'
alias gplf='gfa && git reset --hard origin/$(git rev-parse --abbrev-ref HEAD 2> /dev/null)'

alias gap='git add --patch'
alias gb='git branch'; __git_complete gb _git_branch
alias gbd='git branch --delete'; __git_complete gbd _git_branch

alias gcl='git clone'; __git_complete gcl _git_clone
alias gcm='git commit'; __git_complete gcm _git_commit
alias gam='git commit --amend --no-edit'; __git_complete gam _git_commit
alias gck='git checkout'; __git_complete gck _git_checkout

alias gdf='git diff --word-diff=color --word-diff-regex="[A-Za-z0-9_]+"'; __git_complete gdf _git_diff
alias gs='git stash'; __git_complete gs _git_stash
alias gsp='git stash pop'
alias gsm='git submodule'; __git_complete gsm _git_submodule
alias gst='git status'; __git_complete gst _git_status
alias gsh='git show'; __git_complete gsh _git_show

alias gm='git merge'; __git_complete gm _git_merge
alias grb='git rebase'; __git_complete grb _git_rebase

alias grs='git reset'; __git_complete grs _git_reset
alias grh='git reset --hard'; __git_complete grh _git_reset

alias gl="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) \- %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gla='gl --all'

# Cargo aliases

alias c='cargo'

alias ck='cargo check'
alias cka='cargo check --all'
alias ckp='cargo check --package'

alias ct='cargo test'
alias cta='cargo test --all'
alias ctp='cargo test --package'

alias cb='cargo build'
alias cbb='cargo build --bin'
alias cr='cargo run'
alias crb='cargo run --bin'

# Misc aliases

export VISUAL='nano'
export EDITOR='nano'
export PAGER='less'

alias ls='exa --time-style=iso --git --git-ignore'
alias tr='ls -T'
alias rmf='rm -rf'
alias cpr='cp -r'
alias cl='clear'
alias md='mkdir -p'

function mf {
        for file in $@; do
                mkdir -p "$(dirname $file)"
                touch "$file"
        done
}

function mvf {
        if [ $# -ne 2 ]; then
                echo 'Usage: $ mvf path/to/src path/to/dst'
                return 1
        fi

        tmp_path="$(mktemp)"
        mv $1 "$tmp_path"
        rm -r $2
        mkdir -p "$(dirname $2)"
        mv "$tmp_path" $2
}

function rgv {
        rg -p "$@" | less -R
}

# .bashrc should be idempotent
if [[ "$BASHRC_IDEMPOTENT_GUARD" == "MARKED" ]]
then return
else export BASHRC_IDEMPOTENT_GUARD="MARKED"
fi

export PATH="\
/usr/local/bin:\
/usr/bin:\
$HOME/.cargo/bin:\
$HOME/.local/npm/bin:\
$PATH"
