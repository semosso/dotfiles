# set up the prompt; using Pure theme
fpath+=($HOME/.config/pure)
autoload -Uz promptinit; promptinit
PURE_CMD_MAX_EXEC_TIME=1
zstyle :prompt:pure:path color 051
zstyle :prompt:pure:prompt:success color 220
zstyle :prompt:pure:prompt:error color 197
zstyle :prompt:pure:git:branch color 035
zstyle :prompt:pure:git:dirty color 168
prompt pure

# alternatively, no theme, custom prompt
#setopt PROMPT_SUBST
#PROMPT="%F{51}%2~%f %B%F{202}%(!.#.%%)%f%b "
#RPROMPT="%(?.%F{83}?0.%F{202}?%?)%f %F{220}(%*)%f" 

# LS_COLORS is used by GNU ls. LSCOLORS is used by BSD ls.
export LS_COLORS='di=1;36:ln=35:so=32:pi=33:ex=36;44:bd=30;46:cd=34;43:su=30;41:sg=31;46:tw=30;42:ow=30;43'
# export LSCOLORS='Gxfxcxdxgeegedabagacad'

# Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

# history configurations
HISTSIZE=2000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt extended_history # saves additional info
setopt hist_ignore_all_dups # do not store duplications
setopt hist_expire_dups_first # expire duplicates first 
setopt share_history # share history across multiple sessions
setopt append_history # appends rather than overwrite history

# Use modern completion system
setopt auto_cd
setopt hist_verify
setopt correct
setopt correct_all

autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# aliases
## start and terminate the EC2 instance running Foundry VTT
alias foundry="aws ec2 start-instances --instance-ids "i-045f918ab7c6d7e68" --profile admin"
alias stopfoundry="aws ec2 stop-instances --instance-ids "i-045f918ab7c6d7e68" --profile admin"
## backing up Obsidian vaults to S3
alias bkobs="tar czvf ~/obsidian.tar.gz ~/Documents/Obsidian/ && aws s3 mv ~/obsidian.tar.gz s3://auza-main/ --profile admin"
## always coloring ls 
alias ls="ls -a --color=auto"
## making it easier to track dotfiles on github
alias config='/usr/bin/git --git-dir=/home/vinicius/.dotfiles/ --work-tree=/home/vinicius'
## global alias for telegram
alias -g telegram="telegram-desktop"

export MANPAGER="most" # subbing man for most
export MANROFFOPT=-c # fixing man colors 

# syntax highligthing; fast-theme -l for list
source ~/.config/fsh/fast-syntax-highlighting.plugin.zsh

## open apps from terminal
op() {
    nohup $1 & >/dev/null 2>&1
}

. "$HOME/.local/bin/env"
