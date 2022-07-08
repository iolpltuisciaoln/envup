# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting fzf fzf-tab)

zle     -N   fzf-file-widget
bindkey '^F' fzf-file-widget
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':completion:*:kill:*' ignored-patterns '0'
zstyle ':completion:*:*:*:*:processes' command 'ps -auxeww --no-headers'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' extra-opts --preview=$extract';ps --pid=$in[(w)2] -ueww --no-headers' --preview-window=down:50:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:cd:*' fzf-command fzf-cd-widget
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup


source $ZSH/oh-my-zsh.sh

[[ ! -f /etc/zsh/.aliases.docker.zsh ]] || source /etc/zsh/.aliases.docker.zsh
[[ ! -f /etc/zsh/.aliases.zsh ]] || source /etc/zsh/.aliases.zsh


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f /etc/zsh/.p10k.zsh ]] || source /etc/zsh/.p10k.zsh
[ -f /etc/zsh/.fzf.zsh ] && source /etc/zsh/.fzf.zsh
