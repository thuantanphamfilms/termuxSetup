setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt autocd                                                   # if only directory path is entered, cd there.

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

PROMPT=" %F{blue}%~%f %F{red}❯%f%F{yellow}❯%f%F{green}❯%f "

setopt histignorealldups sharehistory

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/zsh/.zsh_history

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -v

# # Change cursor shape for different vi modes.
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
zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

mk () {
    if [ ! -n "$1" ]; then
        echo "Enter a directory name"
    elif [ -d $1 ]; then
        echo "\`$1' already exists"
        cd $1
    else
        mkdir $1 && cd $1
    fi
}

BMI () {
    bash ~/git/termuxSetup/zsh/functions/BMI.py
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

runcpp () {
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

########################################################################

set -U EDITOR nvim
export EDITOR='nvim'
export VISUAL='nvim'
export PATH="$HOME/.npm/bin:$PATH"

# alias l='ls -lha'
alias l='clear ; exa -al --color=always --group-directories-first'
alias ls='clear ; exa -al --color=always --group-directories-first'
alias sl='clear ; exa -al --color=always --group-directories-first'
alias la='clear ; exa -a --color=always --group-directories-first'
alias l.='clear ; exa -a | egrep "^\."'
alias ll='clear ; exa -l --color=always --group-directories-first'
alias lt='clear ; exa -aT --color=always --group-directories-first'

alias cpf='xclip -sel clip'
alias re='source ~/.config/zsh/.zshrc ; tmux source-file ~/.tmux.conf'
alias tmuxr='tmux source ~/.tmux.conf'
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
alias n='nnn -de'

# alias ins='sudo dnf install -y'
# alias uins='sudo dnf remove -y'

# arch
alias ins='pkg install -y'
alias uins='pkg remove -t'

alias ide='tmux split-window -v -p 20 ; tmux split-window -h -p 75 ; tmux last-pane ; nvim'
# alias ide='tmux split-window -h -p 30 ; tmux split-window -v -p 75 ; tmux last-pane ; nvim'
alias qa='tmux kill-session -a ; cowsay "All session deleted" ; tmux ls'

alias ..='cd .. ; clear ; l'
alias ...='cd .. ; cd .. ; cd .. ; clear ; l'
alias dow='cd ~/Downloads ; clear ; l'

alias yt='youtube-dl --add-metadata -i'
alias yta='yt -x --audio-format mp3'

alias t='trash'
alias tdl='trash ~/Downloads/*'

alias cf='cd ~/.config/ ; nvim -o $(fzf)'
alias vi='cd ~/ ; nvim -o $(fzf)'
export FZF_DEFAULT_COMMAND='fd -H --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# paper color
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --color=fg:#4d4d4c,bg:#eeeeee,hl:#d7005f
# --color=fg+:#4d4d4c,bg+:#e8e8e8,hl+:#d7005f
# --color=info:#4271ae,prompt:#8959a8,pointer:#d7005f
# --color=marker:#4271ae,spinner:#4271ae,header:#4271ae'

# gruvbox dark
 export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
 --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
 --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54'

c () {
    local dir
    dir=$(find ~ -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) &&
        cd "$dir"
            clear
            la
        }

alias yo='git add -A ; git commit -m "$(curl -s whatthecommit.com/index.txt)"'
alias sta='git status'
alias push="git push"
alias pull="git pull"
alias clone='git clone'
alias commit='git commit -m'
alias prettier='prettier --write .'
alias ok='yo ; push'
alias okp='prettier ; yo ; push '

ghtermuxSetup () {
    cp ~/.config/tmux/.tmux.conf ~/git/termuxSetup/tmux/
    cp ~/.config/zsh/.zshrc ~/git/termuxSetup/zsh/
    cp -r ~/.config/zsh/functions ~/git/termuxSetup/zsh
    cp ~/.config/nvim/coc-settings.json ~/git/termuxSetup/nvim/
    cp ~/.config/nvim/init.vim ~/git/termuxSetup/nvim/
    cp -r ~/.config/nvim/coc-settings.json ~/git/termuxSetup/nvim/
    cp -r ~/.config/nvim/stuff ~/git/termuxSetup/nvim/
    cp ~/.gitconfig  ~/git/termuxSetup/git/
    cp ~/.selected_editor ~/git/termuxSetup
    cp ~/.ssh/config ~/git/termuxSetup/ssh
    cd ~/git/termuxSetup/
    okp ; cd -
}

gha () {
    cowsay "git push termuxSetup" ; ghtermuxSetup
    cowsay "D O N E"
}

alias glcalculatorOnIOS='cd ~/git/calculatorOnIOS ; pull ; cd -'
alias gldataLab='cd ~/git/dataLab ; pull ; cd -'
alias gldotfiles='cd ~/git/dotfiles ; pull ; cd -'
alias glfour-card-feature-section='cd ~/git/four-card-feature-section ; pull ; cd -'
alias glFreeCodeCampProject='cd ~/git/FreeCodeCampProject ; pull ; cd -'
alias glimg='cd ~/git/img ; pull ; cd -'
alias gllazyscript='cd ~/git/lazyscript ; pull ; cd -'
alias gllinux_setup='cd ~/git/linux_setup ; pull ; cd -'
alias glok='cd ~/git/ok ; pull ; cd -'
alias gltermuxSetup='cd ~/git/termuxSetup ;  pull ; cd -'
alias gltheNewsTimes='cd ~/git/theNewsTimes ; pull ; cd -'
alias glthuanpham2311='cd ~/git/thuanpham2311 ; pull ; cd -'
alias glvimium_dark_theme='cd ~/git/vimium_dark_theme ; pull ; cd -'
alias glwindowsSetup='cd ~/git/windowsSetup ;  pull ; cd -'
alias glstuDarkTheme='cd ~/git/stuDarkTheme ;  pull ; cd -'

gla () {
    cowsay "git pull lazyscript" ; gllazyscript
    cowsay "git pull dotfiles" ; gldotfiles
    cowsay "git pull linux_setup" ; gllinux_setup
    cowsay "git pull vimium-dark-theme" ; glvimium_dark_theme
    cowsay "git pull FreeCodeCampProject" ; glFreeCodeCampProject
    cowsay "git pull ok" ; glok
    cowsay "git pull dataLab" ; gldataLab
    cowsay "git pull windowsSetup" ; glwindowsSetup
    cowsay "git pull termuxSetup" ; gltermuxSetup
    cowsay "git pull img" ; glimg
    cowsay "git pull thuanpham2311" ; glthuanpham2311
    cowsay "git pull theNewsTimes" ; gltheNewsTimes
    cowsay "git pull four-card-feature-section" ; glfour-card-feature-section
    cowsay "git pull calculatorOnIOS" ; glcalculatorOnIOS
    cowsay "git pull stuDarkTheme" ; glstuDarkTheme
    cowsay "D O N E"
}

hi () {
    gla ; gha ; rem
}

rem () {
    nvim -c "PlugUpdate | qa"
    npm -g install neovim
    npm -g install npm
    gem update neovim
    python -m pip install neovim
    python -m pip install --upgrade pip

    # debian base (ubuntu, kali,...)
    apt update
    apt upgrade -y
    apt autoremove -y
    apt autoclean

    cd ~ ; clear ; neofetch
}
