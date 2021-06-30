# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH="/root/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# HIST_STAMPS="mm/dd/yyyy"

# ENV
export DISPLAY=:0
export LANG=en_GB.UTF-8
export LANGUAGE=en_US
export FZF_TMUX_HEIGHT=75
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
export MANPAGER="sh -c 'bat -l man -p'"

export TERM=screen-256color #screen-256color xterm-256color

export COLORTERM=truecolor
#export FZF_DEFAULT_OPTS="--height 60% --reverse --border --preview 'head -100 {}'"
# export FZF_DEFAULT_OPTS="--height 75% --reverse --border --preview 'tree -C {} | head -200'"
export FZF_DEFAULT_OPTS="+s --height 75% --reverse --border --preview-window hidden --bind '?:toggle-preview'"
#export FZF_DEFAULT_OPTS="--height 75% --reverse --border --preview 'tree -C {} | bat --style=numbers --color=always --line-range :500 {}'"
#export FZF_DEFAULT_OPTS='--height 75% --ansi --border --preview "if file {} | grep -i 'text'; then head -100 {}; fi"'
#export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always --line-range :500 {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="+s --preview 'fzf-my-preview {}' --preview-window nohidden"
export FZF_CTRL_R_OPTS="+s --preview 'echo {}' --preview-window 'down:4:wrap:nohidden'"
export FZF_ALT_C_OPTS="+s --preview-window nohidden --preview 'tree -C {} | head -200'"
export FZF_COMPLETION_TRIGGER='**' #!!


HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS
setopt hist_ignore_dups

#_fzf_compgen_dir() {
#   #copy-paste from fzf-cd-widget
#    command find -L "$1" -mindepth 1 \( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -#fstype 'devtmpfs' -o -fstype 'proc' \) -prune  -o -type d -print 2> /dev/null | cut -b3-
#  }

# source /usr/share/fzf/shell/completion.zsh
# source /usr/share/fzf/shell/key-bindings.zsh

zle     -N   fzf-file-widget
bindkey '^F' fzf-file-widget
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree -C $realpath | head -200'

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf fzf-tab)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.aliases.docker.zsh ]] || source ~/.aliases.docker.zsh
[[ ! -f ~/.aliases.zsh ]] || source ~/.aliases.zsh

accept-line() {
  if [[ -z $BUFFER ]]; then
    zle -I
    l
  else
    zle ".$WIDGET"
  fi
}

zle -N accept-line


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#    (tmux attach-session -t 0 && tmux source /usr/share/tmux/powerline.conf)|| tmux new -s 0
if [ -z "$TMUX" ]; then
    tmux attach-session -t 0 || tmux new -s 0
fi