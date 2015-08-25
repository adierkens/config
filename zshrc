# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export VIEW=/usr/bin/elinks

function url-encode; {
    setopt extendedglob
    echo "${${(j: :)@}//(#b)(?)/%$[[##16]##${match[1]}]}"
}

function google; {
    $VIEW "http://www.google.com/search?q=`url-encode '${(j: :)@'`"
}

#
setopt AUTO_CD      # Don't need to type cd
setopt CORRECT      # Spell check
setopt AUTO_PUSHD   # cd = pushd
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME # blank pushd goes to home
setopt RM_STAR_WAIT # 10 second delay if you do something that'll delete everything
setopt ZLE
export EDITOR="vim"
setopt IGNORE_EOF
setopt NO_BEEP

bindkey -M viins '\C-i' complete-word

# Faster! (?)
 zstyle ':completion::complete:*' use-cache 1
#
# # case insensitive completion
 zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
#
 zstyle ':completion:*' verbose yes
 zstyle ':completion:*:descriptions' format '%B%d%b'
 zstyle ':completion:*:messages' format '%d'
 zstyle ':completion:*:warnings' format 'No matches for: %d'
 zstyle ':completion:*' group-name ''
#
# # generate descriptions with magic.
 zstyle ':completion:*' auto-description 'specify: %d'
#
# # Don't prompt for a huge list, page it!
 zstyle ':completion:*:default' list-prompt '%S%M matches%s'
#
# # Don't prompt for a huge list, menu it!
 zstyle ':completion:*:default' menu 'select=0'
#
# # Have the newer files last so I see them first
 zstyle ':completion:*' file-sort modification reverse
#
# # color code completion!!!!  Wohoo!
 zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
#
 unsetopt LIST_AMBIGUOUS
 setopt  COMPLETE_IN_WORD
#
# # Separate man page sections.  Neat.
 zstyle ':completion:*:manuals' separate-sections true
#
# # Egomaniac!
 zstyle ':completion:*' list-separator 'fREW'
#
# # complete with a menu for xwindow ids
 zstyle ':completion:*:windows' menu on=0
 zstyle ':completion:*:expand:*' tag-order all-expansions
#
# # more errors allowed for large words and fewer for small words
 zstyle ':completion:*:approximate:*' max-errors 'reply=(  $((  ($#PREFIX+$#SUFFIX)/3  ))  )'
#
# # Errors format
 zstyle ':completion:*:corrections' format '%B%d (errors %e)%b'
#
# # Don't complete stuff already on the line
 zstyle ':completion::*:(rm|vi):*' ignore-line true
#
# # Don't complete directory we are already in (../here)
#
 zstyle ':completion::approximate*:*' prefix-needed false
#

function prompt_char {
  git branch >/dev/null 2>/dev/null && echo "±" && return
  echo '○'
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

local ruby_env=''
if which rvm-prompt &> /dev/null; then
  ruby_env=' ‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    ruby_env=' ‹$(rbenv version-name)›%{$reset_color%}'
  fi
fi

local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'
local prompt_char='$(prompt_char)'

export MAVEN_OPTS=-Xmx1024m

PROMPT="╭─%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(box_name)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}${current_dir}%{$reset_color%}${git_info} %{$FG[239]%}using%{$FG[243]%}${ruby_env}
╰─${prompt_char} "

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[239]%}on%{$reset_color%} %{$fg[255]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}✘✘✘"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}✔"

alias gs="git status"
alias gc="git commit -s"

export MORSE_BLENDER=/Applications/Blender.app/Contents/MacOS/blender
