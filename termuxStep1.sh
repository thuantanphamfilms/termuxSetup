pkg install startship proot man python zsh tmux curl wget git neofetch htop mpv net-tools neovim fd aria2 tree cowsay fzf clang ripgrep unrar moreutils nnn exa lua53 nodejs termux-api tig bat -y

# use npm install --global without sudo
npm config set prefix ~/.npm

npm install --global prettier
# go to tinypng get tinypng dev API and paste it to file .tinypng at $HOME
npm install --global tinypng-cli
npm install --global browser-sync
npm install --global yarn
npm install --global neovim
npm install --global typescript

pip3 install speedtest-cli
pip3 install pynvim
pip3 install pylint

# ruby
apt install ruby -y
# optional neovim
gem install neovim

# nvim setup
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
