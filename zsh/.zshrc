# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="uzuto"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="archcraft"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
DISABLE_LS_COLORS="false"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="geany ~/.zshrc"
# alias ohmyzsh="geany ~/.oh-my-zsh"

# On-demand rehash
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd


# Configure alacritty's colurs with wal
if command -v wal > /dev/null 2>&1 && [ "$TERM" = "alacritty" ]; then
    wal -Rqe
fi

# What to display when zsh starts
macchina
crunchbang

# omz
alias zshconf="geany ~/.zshrc"
alias ohmyzsh="thunar ~/.oh-my-zsh"

# NNN
eval "$(jump shell zsh)"
export NNN_FCOLORS='000000'
export NNN_FIFO="/home/uzuto/.nnn.fifo"
alias nnn='nnn -e'
export NNN_PLUG='j:autojump;f:fzcd;p:preview-tui;s:suedit;o:fzopen;v:imgview'

# ls
alias l='ls -lh'
alias ll='ls -lah'
alias la='ls -A'
alias lm='ls -m'
alias lr='ls -R'
alias lg='ls -l --group-directories-first'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

## UZUTO'S CONFIG ##

# envs
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.local/bin/:$PATH
export PATH=$HOME/.cargo/bin:$PATH

export MPD_HOST=$HOME/.mpd/socket

# basic stuff
alias cls='clear'
alias rmr='rm -r'
alias cdd='cd /run/media/uzuto/WIN11'
alias updt='yay --noconfirm'
alias ccat='pygmentize -g'

# aria2c
alias dl1='aria2c -j 1 --summary-interval=0 -i'
alias dl='aria2c --summary-interval=0'
alias dlt='aria2c --summary-interval=0 --seed-time=0'

# software
alias web='links'
alias fm='ranger'
alias music='$HOME/.ncmpcpp/scripts/ncmpcpp-art'
alias night='sct 4000'
alias server='miniserve -D -H -t UzuServe'
alias tordl='transmission-daemon -gsr 0 --no-incomplete-dir -w /run/media/uzuto/Local\ Disk/.SID && tremc'
alias nyaastream='nyaadl --command "webtorrent -i --mpv {}"'
# alias android='cage waydroid -- show-full-ui'
alias u2m='u2 -m'
alias ts='webtorrent --mpv -i'
alias weather="curl https://wttr.in/gwalior"

# ytdlp
alias ytdl-v='yt-dlp -f "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --write-auto-subs --write-subs --sub-lang en'
alias ytdl-a='yt-dlp --extract-audio --audio-format mp3 --audio-quality 320K --add-metadata --embed-thumbnail'
alias ytdl-4k='yt-dlp -f "bestvideo[ext=mp4][height<=2160]+bestaudio[ext=m4a]/bestvideo[ext=mp4][height<=1440]+bestaudio[ext=m4a]/bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]"'

# system stuff
alias genlink='sudo ~/Softwares/ventoy/VentoyVlnk.sh -c'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias gensyslog="sudo journalctl -b | curl -F 'file=@-' 0x0.st"
alias logup="curl -F 'file=@-' 0x0.st"
alias tb="nc termbin.com 9999"
alias startsmb="sudo systemctl start smb nmb"
alias stopsmb="sudo systemctl stop smb nmb"

# hardware related

# disable wifikill when lid close (disable sleep first)
alias wifinokill="sudo setkeycodes e057 240 e058 240"

#screen off
alias screendown='xset -display :0.0 dpms force off'
alias lolsrch='xdg-open "$(lolcate | rofi -threads 0 -width 160 -dmenu -i -p "lolcate:" -theme "~/.bin/anitheme/lolcate.rasi")"'

# ASUS TUF A15 stuff
alias rogc="weston -- rog-control-center"
alias cat="bat"
#source /home/uzuto/.local/pipx/venvs/fastanime/fastanime.zsh

export PATH=$PATH:/home/uzuto/.spicetify

alias droid="WAYLAND_DISPLAY=wayland-1 && weston --shell="kiosk-shell.so" --fullscreen --width=1920 --height=1080  -- waydroid show-full-ui && waydroid session stop"
