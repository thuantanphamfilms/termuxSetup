#!/usr/bin/fish

# funtions stuff
function 256color
	bash ~/.config/fish/functions/print256colours.sh
end

function showTrueColor
	bash ~/.config/fish/functions/showTrueColor.sh
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
	if test "$argv" = !!
		eval command sudo $history[1]
	else
		command sudo $argv
	end
end

function dl --description "download file like bitTorrent,..."
	cd ~/Downloads
	aria2c $argv
	ls -lah ~/Downloads
	cd -
end

function run --description "run test for c/cpp, Python"
	if ls $argv | grep ".cpp"
		g++ $argv
		./a.out
		rm a.out
	else if ls $argv | grep ".c"
		gcc $argv
		./a.out
        rm a.out
	else if ls $argv | grep ".py"
		python3 $argv
	end
end

function repeat
	while true
		$argv
		sleep 1
	end
end

function SERVER_IP --description "live server, go to folder project, have index.html"
	hostname -I
end

function se
	browser-sync start --server --files . --no-notify --host SERVER_IP --port 9000
end

########################################################################

set -g -x fish_greeting Yo!

set -g fish_term24bit 1
fzf_key_bindings
fish_vi_key_bindings
set -U EDITOR nvim

# lazy code
alias fishr='source ~/.config/fish/config.fish'
alias g='grep'
alias h='htop'
alias ins='apt install -y'
alias uins='apt remove -y'
alias e='exit'
alias :q='exit'
alias l='clear ; ls -lah'
alias p='ipython3'
alias mkd='mkdir -pv'
alias ka='killall'
alias fi='vifm'
alias v='nvim'
alias o='open'
alias fd='fdfind'
alias 777='chmod -R 777'
alias x='chmod +x'
alias cf='cd ~/.config/ ; nvim -o (fzf)'

function rem --description "update"
	 apt update
	 apt upgrade -y
	 apt autoremove -y
	 apt autoclean
	#  snap refresh
	nvim -c "PlugUpdate | qa"
end

# tmux
# alias ide='tmux split-window -v -p 30 ; tmux split-window -h -p 66 ; tmux split-window -h -p 50'
alias ide='tmux split-window -v -p 20 ; tmux split-window -h -p 75'
alias qa='tmux kill-session -a ; tmux ls'

# cd
alias ..='cd .. ; clear ; l'
alias ...='cd .. ; cd .. ; cd .. ; clear ; l'
alias ....='cd .. ; cd .. ; cd .. ; cd .. ; clear ; l'
alias dow='c ~/Downloads'

function c
	cd $argv
	clear
	ls -ltrh
end

# youtube-dl
alias yt='youtube-dl --add-metadata -i (read $link)'
alias yta='yt -x --audio-format mp3 (read $link)'

# trash-cli
alias t='trash'
alias tdl='trash ~/Downloads/*'

# fzf
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

function fc -d "Fuzzy change directory"
	if set -q argv[1]
	set searchdir $argv[1]
	else
	set searchdir $HOME
end

# https://github.com/fish-shell/fish-shell/issues/1362
	set -l tmpfile (mktemp)
	find $searchdir \( ! -regex '.*/\..*' \) ! -name __pycache__ -type d | fzf > $tmpfile
	set -l destdir (cat $tmpfile)
	rm -f $tmpfile

	if test -z "$destdir"
	return 1
	end

	cd $destdir
	clear
	ls -ltrh
end

function fco -d "Fuzzy-find and checkout a branch"
  git branch --all | grep -v HEAD | string trim | fzf | read -l result; and git checkout "$result"
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

# git
alias yo='git add -A ; git commit -m (curl -s whatthecommit.com/index.txt)'
alias sta='git status'
alias push="git push"
alias pull="git pull" 
alias clone='git clone'
alias cm='git commit -m'
alias prettier='prettier --write .'
alias ok='prettier ; yo ; push '

function ghtermuxSetup
	cp ~/.selected_editor ~/git/termuxSetup
	cp ~/.gitconfig  ~/git/termuxSetup/git/
	cp ~/.tmux.conf ~/git/termuxSetup/tmux/
	cp ~/.config/nvim/init.vim ~/git/termuxSetup/nvim
	cp -r ~/.config/fish/* ~/git/termuxSetup/fish/
	cp -r ~/.config/vifm/* ~/git/termuxSetup/vifm/
	cp ~/.ssh/config ~/git/termuxSetup/ssh/
	cd ~/git/termuxSetup/
	ok ; cd -
end

alias ghlazyscript='cd ~/git/lazyscript ; ok ; cd -'
alias ghdotfiles='cd ~/git/dotfiles/ ; ok ; cd -'
alias ghlinux_setup='cd ~/git/linux_setup ; ok ; cd -'
alias ghvimium_dark_theme='cd ~/git/vimium_dark_theme ; ok ; cd -'
alias ghFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; ok ; cd -'
alias ghok='cd ~/git/ok ; ok ; cd -'
alias ghdataLab='cd ~/git/dataLab ; ok ; cd -'
alias ghwindowsSetup='cd ~/git/windowsSetup ;  ok ; cd -'

function gha --description "git push all project"
	cowsay "git push lazyscript"
	ghlazyscript

	cowsay "git push dotfiles"
	ghdotfiles

	cowsay "git push linux_setup" 
	ghlinux_setup

	cowsay "git push vimium-dark-theme" 
	ghvimium_dark_theme

	cowsay "git push FreeCodeCampProject" 
	ghFreeCodeCampProject

	cowsay "git push ok" 
	ghok

	cowsay "git push dataLab" 
	ghdataLab

	cowsay "git push windowsSetup" 
    ghwindowsSetup

	cowsay "git push termuxSetup" 
    ghtermuxSetup
	cowsay "D O N E"
end

alias gldotfiles='cd ~/git/dotfiles ; pull ; cd -'
alias gllazyscript='cd ~/git/lazyscript ; pull ; cd -'
alias gllinux_setup='cd ~/git/linux_setup ; pull ; cd -'
alias glvimium_dark_theme='cd ~/git/vimium_dark_theme ; pull ; cd -'
alias glFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; pull ; cd -'
alias glok='cd ~/git/ok ; pull ; cd -'
alias gldataLab='cd ~/git/dataLab ; pull ; cd -'
alias glwindowsSetup='cd ~/git/windowsSetup ;  pull ; cd -'
alias gltermuxSetup='cd ~/git/termuxSetup/ ;  pull ; cd -'

function gla --description "git pull all project"
	cowsay "git pull lazyscript" 
	gllazyscript 

	cowsay "git pull dotfiles" 
	gldotfiles 

	cowsay "git pull linux_setup" 
	gllinux_setup 

	cowsay "git pull vimium-dark-theme" 
	glvimium_dark_theme

	cowsay "git pull FreeCodeCampProject" 
	glFreeCodeCampProject 

	cowsay "git pull ok" 
	glok

	cowsay "git pull dataLab" 
	gldataLab

	cowsay "git pull windowsSetup" 
    glwindowsSetup

	cowsay "git pull windowsSetup" 
    gltermuxSetup
end

alias hi='rem ; gla ; gha'
