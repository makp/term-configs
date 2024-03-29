# -*-conf-*-
# ~/.zshrc
# In order to change the default shell, use: usermod -s /bin/<shell> <username>


# Load .zsh_private if it exists
if [[ -f ~/.zsh_private ]]; then
  source ~/.zsh_private
fi

# load colors
autoload -U colors 
colors

## KEYBINDINGS ---------

bindkey "^[[1~" beginning-of-line # HOME 
bindkey "^[[4~" end-of-line # END
bindkey "\e[3~" delete-char # DEL

bindkey "^[h" backward-kill-word # M-h

bindkey "^[n" down-line-or-history
bindkey "^[t" up-line-or-history

# VARIABLES -----------------------

# path
PATH="$PATH:/usr/bin/vendor_perl:/home/makmiller/scripts/myscripts:$HOME/.local/bin"
export PATH

# editor
export EDITOR=/usr/bin/vim
export VISUAL=/home/makmiller/scripts/myscripts/edit.sh
export ALTERNATE_EDITOR=nvim

# CDPATH
# The nullstring "::" forces cd to search in the working directory
# This is important because, without it, cd will only search the working
# directory after the other directories in CDPATH fails. 
export CDPATH=::$HOME:$HOME/Documents/mydocs

# max size directory stack
DIRSTACKSIZE=12

#dirs `cat $HOME/.zsh_dir-stack` # permanent directory stack

# start ssh-agent (from Arch Linux page on ssh keys)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(<"$XDG_RUNTIME_DIR/ssh-agent.env")"
fi
# This will run a ssh-agent process if there is not one already, and save the output thereof. If there is one running already, we retrieve the cached ssh-agent output and evaluate it which will set the necessary environment variables.


# rehash automatically
zstyle ':completion:*' rehash true

# words
# for zsh, not just alphanumerics are part of a word, but other symbols stated by the shell variable WORDCHARS. By making this variable empty, I get the bash behavior. 
# default value
# WORDCHARS=*?_-.[]~=/&;!#$%^(){}<>
export WORDCHARS="?[]~=&;!#$%^(){}<>"
# I removed the symbols: *./-_



# my prompt
## PS1 (primary)
export PS1="%{$fg[green]%}%1c> %{$reset_color%}"

# history related
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.zsh_history
export SAVEHIST=$HISTSIZE # save history

# mail
# export MAILCHECK=120 # how often (in seconds) shell checks for new email
# export MAILPATH=/home/makmiller/Mail/default/cur # pathname of the file that holds your mail 
# 
#export MAIL # in the case of the variable mail 

## OPTIONS --------------
setopt NO_BEEP	      # disable beeping
setopt ignore_eof     # exit only if I press C-d ten times in a row
setopt auto_cd        # change directory by typing a directory name 
setopt extended_glob  # turn on the more powerful pattern matching features
# With this option, the characters ^, ~, and # become special wherever they appear unquoted
setopt correctall     # enable correction commands typed
setopt NOTIFY	      # notify when jobs finish
setopt nohup
setopt share_history 		# share history between shell instances

# -- directory stack options
setopt autopushd		# make cd always behave like pushd
setopt pushd_ignore_dups	# disable multiple copies of the same
				# directory on the directory stack
setopt pushd_silent   # don't print the directory stack after pushd or
		      # popd


# history related
setopt hist_ignore_all_dups 
setopt hist_ignore_space

# COMPLETION ----

# compinit
autoload -U compinit
compinit

# fzf
# Enable fzf if it is installed
if command -v fzf >/dev/null 2>&1; then
    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    # bindkey '' fzf-file-widget
    # bindkey '' fzf-cd-widget
fi

# predict
# autoload predict-on
# predict-on

# syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# THINGS TO DO 
# use directory-stack with tab completion
# save my directory-stack (persistent directory stack)

# autocompletion for aliases
# setopt COMPLETE_ALIASES

# zstyle

# enable caching (for speed)
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# general completion
zstyle ':completion:*' menu select # activate menu selection
zstyle ':completion:*' verbose yes # print descriptions against each match
zstyle ':completion:*' group-name '' # separate matches in distinct related groups

# use internal pager to display matches
zmodload zsh/complist		 
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
bindkey -M listscroll q send-break # q exits internal pager

# fuzzy matching 
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

zstyle -e ':completion:*:approximate:*' \
    max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)' 
# The number of errors allowed by approximate increase with the length
# of what you have typed so far


# format messages in bold prefixed with ---- 
zstyle ':completion:*' format '%B---- %d%b' 
zstyle ':completion:*:descriptions' format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}' 
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"  

# process completion
zstyle ':completion:*:*:*:*:processes' insert-ids menu yes select 
# when completing process IDs fall into menu selection

zstyle ':completion:*:*:*:*:processes' force-list always
# always display the list (even if there is only one possible completion)

# process name completion
zstyle ':completion:*:processes' command 'ps c -u ${USER} -o pid,%cpu,cputime,cmd' 
# alternative completions: tty #'ps -U $(whoami) | sed "/ps/d"'

# kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# complete manpages by section
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.*' insert-sections true

# colors
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# cd will never select the parent directory (e.g.: cd../<TAB>)
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# helper functions
okular() { command okular ${*:-*.pdf(om[1])} }
zstyle ':completion:*:*:okular:*' menu yes select
zstyle ':completion:*:*:okular:*' file-sort time

# completing on the prefix
# (i.e., complete in the middle of some text ignoring the suffix)
bindkey '^i' expand-or-complete-prefix # binding TAB

# CUSTOM FUNCTIONS ----------------

# # do ls right after cd
# cd () {
#   if [ -n $1 ]; then
#     builtin cd "$@" && ls
#   else
#     builtin cd ~ && ls
#   fi
# }
