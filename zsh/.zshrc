zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' rehash true
zstyle ':completion:*' accept-exact '*(N)'
WORDCHARS=${WORDCHARS//\/[&.;]}

autoload -U colors && colors
eval "$(starship init zsh)"

setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

bindkey -v

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
            echo -ne '\e[1 q'
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
                    echo -ne '\e[5 q'
    fi
}

zle -N zle-keymap-select
zle-line-init() {
zle -K viins
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'
preexec() { echo -ne '\e[5 q' ;}

autoload -Uz compinit
compinit

light () {
    echo "source ~/git/termuxSetup/zsh/functions/lightFzf.zsh" > ~/git/termuxSetup/zsh/themeFzf.zsh
    echo "
set background=light
colorscheme PaperColor" > ~/git/dotfiles/nvim/darkOrLight.vim
    echo "--theme=\"GitHub\"" > ~/git/dotfiles/bat/config
}

dark () {
    echo "source ~/git/termuxSetup/zsh/functions/darkFzf.zsh" >  ~/git/termuxSetup/zsh/themeFzf.zsh
    echo "
set background=dark
colorscheme gruvbox-material" > ~/git/dotfiles/nvim/darkOrLight.vim
    echo "--theme=\"OneHalfDark\"" > ~/git/dotfiles/bat/config
}

mk () {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "\`$1' already exists"
        cd $1
    else
        mkdir -p $1 && cd $1
    fi
}

bmi () {
    python3 ~/git/termuxSetup/zsh/functions/bmi.py
}

tv () {
    bash ~/git/termuxSetup/zsh/functions/tv.sh
}

u () {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar -jxvf $1                        ;;
            *.tar.gz)   tar -zxvf $1                        ;;
            *.bz2)      bunzip2 $1                          ;;
            *.dmg)      hdiutil mount $1                    ;;
            *.gz)       gunzip $1                           ;;
            *.tar)      tar -xvf $1                         ;;
            *.tbz2)     tar -jxvf $1                        ;;
            *.tgz)      tar -zxvf $1                        ;;
            *.zip)      unzip $1                            ;;
            *.ZIP)      unzip $1                            ;;
            *.pax)      cat $1 | pax -r                     ;;
            *.pax.Z)    uncompress $1 --stdout | pax -r     ;;
            *.rar)      unrar x $1                          ;;
            *.Z)        uncompress $1                       ;;
            *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

24-bit-color () {
    bash ~/git/termuxSetup/zsh/functions/24-bit-color.sh
}

print256colours () {
    bash ~/git/termuxSetup/zsh/functions/print256colours.sh
}

showTrueColor () {
    bash ~/git/termuxSetup/zsh/functions/showTrueColor.sh
}

dl () {
    cd ~/Downloads
    aria2c $argv
    ls -lah ~/Downloads
    cd -
}

run () {
    if ls $argv | grep ".cpp"
    then
        g++ $argv
        ./a.out
        rm a.out
    elif ls $argv | grep ".c"
    then
        gcc $argv
        ./a.out
        rm a.out
    fi
}

cpppro () {
    mkdir $argv
    cd $argv
    cp -r ~/.config/nvim/stuff/cpppro/* .
    nvim -O *
}

runcpp() {
    g++ *.cpp
    ./a.out
    rm a.out
}

r () {
    while true
    do
        $argv
        sleep 1
    done
}

SERVER_IP () {
    hostname -I
}

se () {
    browser-sync start --server --files . --no-notify --host SERVER_IP --port 9000
}

########################################################################

set -U EDITOR nvim
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.npm/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

# alias l='ls -lha'
alias l='clear ; exa -al --color=always --group-directories-first'
alias ls='clear ; exa -al --color=always --group-directories-first'
alias sl='clear ; exa -al --color=always --group-directories-first'
alias la='clear ; exa -a --color=always --group-directories-first'
alias l.='clear ; exa -a | egrep "^\."'
alias ll='clear ; exa -l --color=always --group-directories-first'
alias lt='clear ; exa -aT --color=always --group-directories-first'

alias cpf='xclip -sel clip'
alias re='source ~/git/termuxSetup/zsh/.zshrc ; tmux source-file ~/.tmux.conf'
alias h='htop'
alias e='exit'
alias :q='exit'
alias q='exit'
alias p='ipython3'
alias rbn='sudo reboot now'
alias sdn='sudo shutdown now'
alias ka='killall'
alias v='nvim'
alias o='xdg-open'
alias 777='chmod -R 777'
alias x='chmod +x'
alias f='fd . -H | grep --colour=always'
alias cat='batcat'
alias nnn='nnn -de'

# music stuff
alias m='mpv --shuffle ~/Music/*'

# termux pkg
alias ins='pkg install -y'
alias uins='pkg remove -y'

# alias ide='tmux split-window -v -p 20 ; tmux split-window -h -p 75 ; tmux last-pane ; nvim'
alias ide='tmux split-window -v -p 8 ; tmux last-pane ; nvim'
# alias ide='tmux split-window -h -p 30 ; tmux split-window -v -p 75 ; tmux last-pane ; nvim'
alias qa='tmux kill-session -a ; cowsay "All session deleted" ; tmux ls'

alias ..='cd .. ; clear ; l'
alias ...='cd .. ; cd .. ; cd .. ; clear ; l'
alias dow='cd ~/Downloads ; clear ; l'
alias doc='cd ~/Documents ; clear ; l'

alias yt='youtube-dl -f bestvideo+bestaudio'
alias yta='youtube-dl -f "bestaudio" --continue --no-overwrites --ignore-errors --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

# arch
# export FZF_DEFAULT_COMMAND='fd -H --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
alias vi='cd ~/ ; nvim -o "$(fzf)"'


c () {
    local dir
    dir=$(find ~ -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
            clear
            l
}

n () {
    local dir
    dir=$(find ~ -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
        nnn -de
}

alias autoCommit='git add -A \
                ; git commit -m "[:ok_hand:Auto commit] $(curl -s whatthecommit.com/index.txt)"'
alias status='git status -sb'
alias add='git add'
alias push="git push"
alias pull="git pull"
alias clone='git clone'
alias commit='git commit -m'
alias prettier='prettier --write .'
prettierCpp () {
    clang-format --style=Google -i $(find -name '*.h' && find -name '*.cpp')
}
alias ok='status ; autoCommit ; push'
alias okp='prettier ; status ; autoCommit ; push '

alias ghnote='cd ~/storage/shared/note ; ok ; cd -'
alias ghtermuxSetup='cd ~/git/termuxSetup ; okp ; cd -'

alias glcalculatorOnIOS='cd ~/git/calculatorOnIOS ; pull ; cd -'
alias gldataLab='cd ~/git/dataLab ; pull ; cd -'
alias glfour-card-feature-section='cd ~/git/four-card-feature-section ; pull ; cd -'
alias glFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; pull ; cd -'
alias glimg='cd ~/git/img ; pull ; cd -'
alias gllazyscript='cd ~/git/lazyscript ; pull ; cd -'
alias gllinux_setup='cd ~/git/linux_setup ; pull ; cd -'
alias glok='cd ~/git/ok ; pull ; cd -'
alias gltermuxSetup='cd ~/git/termuxSetup ;  pull ; cd -'
alias gltheNewsTimes='cd ~/git/theNewsTimes ; pull ; cd -'
alias glthuanpham2311='cd ~/git/thuanpham2311 ; pull ; cd -'
alias glblog='cd ~/git/thuanpham2311.github.io ; pull ; cd -'
alias glvimium_dark_theme='cd ~/git/vimium_dark_theme ; pull ; cd -'
alias glwindowsSetup='cd ~/git/windowsSetup ;  pull ; cd -'
alias glsuckless='cd ~/git/suckless ;  pull ; cd -'

alias glnote='cd ~/storage/shared/note ;  pull ; cd -'

gla () {
    cowsay "git pull lazyscript" ; gllazyscript
    cowsay "git pull linux_setup" ; gllinux_setup
    cowsay "git pull vimium-dark-theme" ; glvimium_dark_theme
    cowsay "git pull FreeCodeCampProject" ; glFreeCodeCampProject
    cowsay "git pull ok" ; glok
    cowsay "git pull dataLab" ; gldataLab
    cowsay "git pull windowsSetup" ; glwindowsSetup
    cowsay "git pull termuxSetup" ; gltermuxSetup
    cowsay "git pull img" ; glimg
    cowsay "git pull thuanpham2311" ; glthuanpham2311
    cowsay "git pull blog" ; glblog
    cowsay "git pull theNewsTimes" ; gltheNewsTimes
    cowsay "git pull four-card-feature-section" ; glfour-card-feature-section
    cowsay "git pull calculatorOnIOS" ; glcalculatorOnIOS
    cowsay "git pull suckless" ; glsuckless
    cowsay "D O N E"
}

rem () {
    nvim -c "PlugUpdate | qa"
    npm update -g
    npm install -g npm
    gem update neovim
    pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
    tldr --update

    # termux
    pkg update
    pkg upgrade -y

    cd ~ ; clear ; neofetch
}

source ~/git/termuxSetup/zsh/functions/key-bindings.zsh
source ~/git/termuxSetup/zsh/functions/completion.zsh
source ~/git/termuxSetup/zsh/themeFzf.zsh
source ~/git/termuxSetup/zsh/functions/zsh-autosuggestions.zsh
source ~/git/termuxSetup/zsh/functions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
