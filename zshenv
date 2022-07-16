#! PRELOAD FUNCTIONS FIST !#
[ -f /etc/zsh/.fzf.zsh ] && source /etc/zsh/.fzf.zsh
#!

# ENV
export DISPLAY=:0
export LANG=en_US.UTF-8
export LANGUAGE=en_US
COMPLETION_WAITING_DOTS="true"
ENABLE_CORRECTION="true"
export MANPAGER="sh -c 'bat -l man -p'"
export TERM=screen-256color #screen-256color xterm-256color
export COLORTERM=truecolor
export FZF_DEFAULT_OPTS="+s --height 100% --reverse --border --preview-window nohidden --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="+s --preview 'fzf-custom-preview {}' --preview-window nohidden"
export FZF_CTRL_R_OPTS="+s --preview 'echo {}' --preview-window 'down:4:wrap:nohidden'"
export FZF_ALT_C_OPTS="+s --preview-window nohidden --preview 'tree --charset=utf-8 -C {} | head -200'"
export FZF_COMPLETION_TRIGGER='**' #!!

# https://the.exa.website/docs/colour-themes
export EXA_COLORS="sn=32;0:sb=32;0:uu=33;40:gu=33;40:in=0;38:lc=0;38:ur=0;33:uw=0;33:ux=0;33:ue=0;33:gr=0;37:gw=0;37:gx=0;37:tr=0;31:tw=0;31:tx=0;31:da=0;34:uu=0;33:gu=0;37"

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