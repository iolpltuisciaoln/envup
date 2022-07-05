#
# RUN ME WITH THIS COMMAND:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/envup.sh)" "" --unattended
#
export TERM=xterm-256color #screen-256color
export COLORTERM=truecolor

dnf -y install procps iputils zsh git fzf findutils \
    tree mc fd-find ripgrep tmux bat autojump-zsh \
    tmux-powerline htop bmon exa

rm -Rf ~/.oh-my-zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf && cp /tmp/fzf/shell/completion.zsh /usr/share/fzf/shell/ && rm -Rf /tmp/fzf
git clone --depth 1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

usermod root -s /usr/bin/zsh
mv /bin/more /bin/more.bak && ln -s /bin/bat /bin/more

curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshrc --output /etc/zsh/zshrc
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshenv --output /etc/zsh/zshenv
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.docker.zsh --output /etc/zsh/.aliases.docker.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.zsh --output /etc/zsh/.aliases.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/tmux.conf --output /etc/tmux.conf
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/powerline_tmux.json --output /etc/xdg/powerline/themes/tmux/default.json
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/p10k.zsh --output ~/.p10k.zsh


