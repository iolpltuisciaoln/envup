#
# RUN ME WITH THIS COMMAND:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/envup.sh)" "" --unattended
#
export TERM=xterm-256color #screen-256color
export COLORTERM=truecolor

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
DNF_CMD=$(which dnf)

if [ ! -z $DNF_CMD ]; then
    PKG=$DNF_CMD
elif [ ! -z $YUM_CMD ]; then
    PKG=$YUM_CMD
elif [ ! -z $APT_GET_CMD ]; then
    PKG=$APT_GET_CMD
else
    echo "error can't detect package manager"
    exit 1
fi

INSTALL_PKGS="zsh git fzf findutils tree fd-find ripgrep tmux tmux-powerline bat autojump-zsh eza"

for i in $INSTALL_PKGS; do
    sudo $PKG install -y $i
done

rm -Rf ~/.oh-my-zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

rm -Rf ~/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

git clone --depth 1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

more=$(which more)
batcat=$(which bat)

if [ -f $batcat ]; then
    sudo mv $more ${more}.bak
    sudo ln -s $batcat $more
fi

curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshrc >~/.zshrc
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshenv >~/.zshenv
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/tmux_network_bw.sh >~/.tmux_network_bw.sh
chmod +x ~/.tmux_network_bw.sh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.docker.zsh >~/.aliases.docker.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.zsh >~/.aliases.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/tmux.conf >~/.tmux.conf
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/p10k.zsh >~/.p10k.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/fzfzsh >~/.fzf.zsh

sudo usermod -s $(which zsh) $USER

sudo mkdir -p /usr/local/fonts/JetBrainsMono
sudo mkdir -p /usr/local/fonts/FiraMono
sudo mkdir -p /usr/local/fonts/DroidSansMono

sudo curl -s -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz | tar xvJ -C /usr/local/fonts/JetBrainsMono/
sudo curl -s -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.tar.xz | tar xvJ -C /usr/local/fonts/FiraMono/
sudo curl -s -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DroidSansMono.tar.xz | tar xvJ -C /usr/local/fonts/DroidSansMono/

sudo chown -R root: /usr/local/fonts
sudo chmod -R 755 /usr/local/fonts
sudo restorecon -vFr /usr/local/fonts
sudo fc-cache -v
