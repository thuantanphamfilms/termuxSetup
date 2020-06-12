#!/usr/bin/env bash

# termux services
sv-enable sshd
sv-enable crond

mkdir ~/git ; cd ~/git/

git clone https://github.com/thuanpham2311/dotfiles
# git clone git@github.com:thuanpham2311/dotfiles.git
# git clone git@github.com:thuanpham2311/lazyscript.git
# git clone git@github.com:thuanpham2311/linux_setup.git
# git clone git@github.com:thuanpham2311/dataLab.git
# git clone git@github.com:thuanpham2311/FreeCodeCampProject.git
# git clone git@github.com:thuanpham2311/vimium_dark_theme.git
# git clone git@github.com:thuanpham2311/windowsSetup.git
git clone https://github.com/thuanpham2311/termuxSetup
# git clone git@github.com:thuanpham2311/termuxSetup.git
# git clone git@github.com:thuanpham2311/img.git
# git clone git@github.com:thuanpham2311/thuanpham2311.git
# git clone git@github.com:thuanpham2311/four-card-feature-section.git
# git clone git@github.com:thuanpham2311/theNewsTimes.git
# git clone git@github.com:thuanpham2311/calculatorOnIOS.git
# git clone git@github.com:thuanpham2311/ok.git
# ln -sf ~/git/ok/.tinypng ~/.tinypng
# git clone git@github.com:thuanpham2311/stuDarkTheme
# git clone git@github.com:thuanpham2311/thuanpham2311.github.io.git

cd ~/git/termuxSetup/zsh/functions/
git clone https://github.com/zsh-users/zsh-syntax-highlighting
cd

mkdir ~/backupDotfile
mv ~/.config/nvim         ~/backupDotfile
mv ~/.zshrc         ~/backupDotfile
mv ~/.tmux.conf         ~/backupDotfile

ln -sf ~/git/termuxSetup/.termux ~/
ln -sf ~/git/termuxSetup/zsh/.zshrc ~/.zshrc
ln -sf ~/git/termuxSetup/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/git/dotfiles/ssh/config ~/.ssh/config
ln -sf ~/git/dotfiles/nvim ~/.config/
ln -sf ~/git/dotfiles/bat/ ~/.config/
ln -sf ~/git/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/git/dotfiles/.selected_editor ~/.selected_editor

cd
