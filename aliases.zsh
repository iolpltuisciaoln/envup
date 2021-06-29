alias ee='mcedit'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias -g G='| grep -i'
alias l='ls --color=auto -FlahX'

function mans() {
    man -k . | fzf -q "$1" --prompt='man> ' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | bat -l man -p
}

