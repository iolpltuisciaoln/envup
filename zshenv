#! PRELOAD FUNCTIONS FIST !#
[[ ! -f ~/.aliases.zsh ]] || source ~/.aliases.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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
export FZF_HEADER_DEFAULT="info here.........."
export FZF_DEFAULT_OPTS="+s
--no-cycle
--multi
--height 100%
--reverse
--layout=reverse
--border
--preview-window nohidden
--bind 'ctrl-a:select-all'
--bind 'alt-d:deselect-all'
--bind '?:toggle-preview'
--border
"

# export FZF_DEFAULT_OPTS="
# --history=$HOME/.fzf_history
# --layout=reverse
# --info=inline
# --height=80%
# --multi
# --border
# --color=fg:#c0caf5,bg:#1a1b26,hl:#bb9af7
# --color=fg+:#c0caf5,bg+:#292e42,hl+:#7dcfff
# --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
# --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a
# --color=gutter:#1a1b26
# --prompt='> ' --pointer='▶' --marker='✓'
# --header '$FZF_HEADER_DEFAULT'
# --bind 'ctrl-s:select-all'
# --bind 'alt-d:deselect-all'
# --preview-window cycle
# --bind '\:toggle-preview'
# --bind 'ctrl-u:preview-half-page-up'
# --bind 'ctrl-d:preview-half-page-down'
# --bind 'alt-k:page-up'
# --bind 'alt-j:page-down'
# --bind 'ctrl-v:execute(nvim {} < /dev/tty > /dev/tty 2>&1)+accept'
# "



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