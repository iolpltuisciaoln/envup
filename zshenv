#! PRELOAD FUNCTIONS FIST !#
[[ ! -f /etc/zsh/.aliases.docker.zsh ]] || source /etc/zsh/.aliases.docker.zsh
[[ ! -f /etc/zsh/.aliases.zsh ]] || source /etc/zsh/.aliases.zsh
[ -f /etc/zsh/.fzf.zsh ] && source /etc/zsh/.fzf.zsh
#!

# ENV
export DISPLAY=:0
export LANG=en_US.UTF-8
export LANGUAGE=en_US
export FZF_TMUX_HEIGHT=75
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
export MANPAGER="sh -c 'bat -l man -p'"
export TERM=screen-256color #screen-256color xterm-256color
export COLORTERM=truecolor
export FZF_DEFAULT_OPTS="+s --reverse --border --preview-window hidden --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="+s --preview 'fzf-custom-preview {}' --preview-window nohidden"
export FZF_CTRL_R_OPTS="+s --preview 'echo {}' --preview-window 'down:4:wrap:nohidden'"
export FZF_ALT_C_OPTS="+s --preview-window nohidden --preview 'tree --charset=utf-8 -C {} | head -200'"
export FZF_COMPLETION_TRIGGER='**' #!!

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

HISTSIZE=10000000
SAVEHIST=10000000
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS
setopt hist_ignore_dups