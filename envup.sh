#
# RUN ME WITH THIS COMMAND:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/envup.sh)" "" --unattended
#
export TERM=xterm-256color #screen-256color
export COLORTERM=truecolor

YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)
DNF_CMD=$(which dnf)

if [ ! -z $YUM_CMD ]; then
    PKG=$YUM_CMD
elif [ ! -z $APT_GET_CMD ]; then
    PKG=$APT_GET_CMD
else
    echo "error can't detect package manager"
    exit 1;
fi

INSTALL_PKGS="procps iputils zsh git fzf findutils tree mc fd-find ripgrep tmux bat autojump-zsh tmux-powerline htop bmon exa curl"

for i in $INSTALL_PKGS; do
    $PKG install -y $i
done

rm -Rf ~/.oh-my-zsh && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
/tmp/fzf/install
mkdir -p /usr/share/fzf/shell/
cp /tmp/fzf/shell/* /usr/share/fzf/shell/ # key-bindings.zsh completion.zsh
rm -Rf /tmp/fzf

git clone --depth 1 https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

usermod root -s /usr/bin/zsh

if [ ! -z /usr/bin/batcat ]; then
    mv /bin/more /bin/more.bak && ln -s /bin/batcat /bin/more
elif [ ! -z /usr/bin/bat ]; then
    mv /bin/more /bin/more.bak && ln -s /bin/bat /bin/more
fi

curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshrc --output /etc/zsh/zshrc
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/tmux_network_bw.sh --output /etc/zsh/tmux_network_bw.sh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/zshenv --output /etc/zsh/zshenv
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.docker.zsh --output /etc/zsh/.aliases.docker.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/aliases.zsh --output /etc/zsh/.aliases.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/tmux.conf --output /etc/tmux.conf
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/p10k.zsh --output /etc/zsh/.p10k.zsh
curl https://raw.githubusercontent.com/iolpltuisciaoln/envup/master/fzfzsh --output /etc/zsh/.fzf.zsh
echo "">~/.zshrc

