dnf -y install procps iputils zsh git fzf findutils tree mc fd-find ripgrep tmux bat autojump-zsh tmux-powerline htop bmon

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

export TERM=xterm-256color #screen-256color
export COLORTERM=truecolor

omz theme use powerlevel10k/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf && cp /tmp/fzf/shell/completion.zsh /usr/share/fzf/shell/ && rm -Rf /tmp/fzf

git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

usermod root -s /usr/bin/zsh
mv /bin/more /bin/more.bak && ln -s /bin/bat /bin/more

cat >~/.zshrc <<'EOF'
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

export TERM=screen-256color #screen-256color xterm-256color

export COLORTERM=truecolor
#export FZF_DEFAULT_OPTS="--height 60% --reverse --border --preview 'head -100 {}'"
export FZF_DEFAULT_OPTS="--height 75% --reverse --border --preview 'tree -C {} | head -200'"
#export FZF_DEFAULT_OPTS="--height 75% --reverse --border --preview 'tree -C {} | bat --style=numbers --color=always --line-range :500 {}'"
#export FZF_DEFAULT_OPTS='--height 75% --ansi --border --preview "if file {} | grep -i 'text'; then head -100 {}; fi"'
#export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || bat --style=numbers --color=always --line-range :500 {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
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

source /usr/share/fzf/shell/completion.zsh
source /usr/share/fzf/shell/key-bindings.zsh

zle     -N   fzf-file-widget
bindkey '^F' fzf-file-widget
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'tree -C $realpath | head -200'
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf fzf-tab)
source $ZSH/oh-my-zsh.sh

# DOCKER
alias dex="docker exec -i -t"
#alias dps='docker ps -a --format "{{.Names}};({{.Image}});{{.Status}};{{.Ports}}"|sort|column -t -s ";" -W 4|fzf +s --preview-window hidden'

dps() {
    docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}"|sort -r|column -t -s ";" -W 4|fzf +s --preview-window hidden
    }

dsh() {
    local cid
#    cid=$(docker ps -a --format "{{.Names}}"|sort -r|fzf +s --preview-window hidden)
    cid=$(docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}"|sort|column -t -s ";" -W 4|fzf +s --preview-window hidden)
    cid=$(echo $cid|awk '{print $1}')
    [ -n "$cid" ] && docker start "$cid" && docker exec -it "$cid" sh
    }

ds() {
    local cid
#    cid=$(docker ps -a --format "{{.Names}}"|sort -r|fzf +s --preview-window hidden)
    cid=$(docker ps -a --format "{{.Names}};({{.Image}});{{.Ports}}"|sort|column -t -s ";" -W 4|fzf +s --preview-window hidden)
    cid=$(echo $cid|awk '{print $1}')
    [ -n "$cid" ] && docker stop "$cid"
    }

alias dcu="docker-compose up"
alias dcud="docker-compose up -d"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"

function dnames-fn {
    for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
    do
        docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
    done
}

function drm() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf --preview-window hidden -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker rm "$cid"
}

function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac --preview-window hidden| awk '{ print $3 }' | xargs -r docker rmi
}


function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect $DOC | grep -m3 IPAddress | cut -d '"' -f 4 | tr -d "\n"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT|column -t
    unset $OUT
}

alias dip=dip-fn

function dl-fn {
    docker logs $1
}
function dlf-fn {
    docker logs -f $1
}

alias dl=dl-fn
alias dlf='dlf-fn'
alias dpsa="docker ps -a"


alias ee='mcedit'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias -g G='| grep -i'

accept-line() {
  if [[ -z $BUFFER ]]; then
    zle -I
    l
  else
    zle ".$WIDGET"
  fi
}
function fman() {
    man -k . | fzf -q "$1" --prompt='man> ' --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}

zle -N accept-line


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#    (tmux attach-session -t 0 && tmux source /usr/share/tmux/powerline.conf)|| tmux new -s 0
if [ -z "$TMUX" ]; then
    tmux attach-session -t 0 || tmux new -s 0
fi

EOF

cat >/etc/tmux.conf <<'EOF'
set-option -g -q mouse on

# Alt-n: New window
bind -n C-n new-window -c "#{pane_current_path}"

# Alt-[1-9]: Switch to window
bind -n M-1 select-window -t :1
bind -n M-2 select-window -t :2
bind -n M-3 select-window -t :3
bind -n M-4 select-window -t :4
bind -n M-5 select-window -t :5
bind -n M-6 select-window -t :6
bind -n M-7 select-window -t :7
bind -n M-8 select-window -t :8
bind -n M-9 select-window -t :9
bind -n M-0 select-window -t :10

# OSX Clipboard support
bind C-v run "tmux set-buffer $(reattach-to-user-namespace pbpaste); tmux paste-buffer"
bind C-c run "tmux save-buffer - | reattach-to-user-namespace pbcopy"

# # Set window notifications
setw -g monitor-activity on
set -g visual-activity on

# Automatically set window title
set-window-option -g automatic-rename on
set-option -g set-titles on

set -g status-keys vi
set -g history-limit 100000
set -g default-terminal "screen-256color"

# No delay for escape key press
set -sg escape-time 0

set -g status-interval 60
set -g status-left-length 30
set -g status-right-length 70

unbind C-b
#set -g prefix C-a
#bind C-a send-prefix

bind-key -n C-h split-window -v  -c '#{pane_current_path}'
bind-key -n C-v split-window -h  -c '#{pane_current_path}'

# Use Ctrl-arrow keys without prefix key to switch panes
bind -n M-Up    select-pane -U
bind -n M-Down  select-pane -D
bind -n M-Left  select-pane -L
bind -n M-Right select-pane -R

# Use Shift-arrow keys without prefix key to resize panes
bind -n S-up    resize-pane -U
bind -n S-down  resize-pane -D
bind -n S-left  resize-pane -L
bind -n S-right resize-pane -R

# Swap panes (Alt)
bind -n C-M-up    swap-pane -U
bind -n C-M-down  swap-pane -D
bind -n C-M-left  select-pane -L \; swap-pane -s '!'
bind -n C-M-right select-pane -R \; swap-pane -s '!'

# Broadcast input multiple windows
bind -n M-b setw synchronize-panes

set -sg escape-time 0

set -g status-interval 1
set -g status-justify left # center align window list
set -g status-left-length 40
set -g status-right-length 140

# Start numbering at 1
set -g base-index 1

# Rather than constraining window size to the maximum size of any client
# connected to the *session*, constrain window size to the maximum size of any
# client connected to *that window*. Much more reasonable.
setw -g aggressive-resize on

# set to main-horizontal, 60% height for main pane
bind m set-window-option main-pane-height 60\; select-layout main-horizontal

source-file /usr/share/tmux/powerline.conf

EOF

cat >/etc/xdg/powerline/themes/tmux/default.json <<'EOF'
{
        "segments": {
                "right": [
                        {
                                "function": "powerline.segments.common.sys.system_load",
                                "priority": 50
                        },
                        {
                                "function": "powerline.segments.common.net.network_load"
                        }
                ]
        }
}
EOF
