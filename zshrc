# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#! Не меня порядок следующих 4х строк !#
export ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(z git zsh-autosuggestions zsh-syntax-highlighting fzf fzf-tab)
source $ZSH/oh-my-zsh.sh
#!####################################!#

zle     -N   fzf-file-widget
bindkey '^F' fzf-file-widget
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':completion:*:(kill|ps):*' ignored-patterns '0'
zstyle ':completion:*:*:*:*:processes' command 'ps -auxfww --no-headers'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview 'ps --pid=$word -o cmd -f --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap 

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-custom-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:cd:*' fzf-command fzf-cd-custom-widget

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f /etc/zsh/.p10k.zsh ]] || source /etc/zsh/.p10k.zsh
