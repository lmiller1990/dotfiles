setopt PROMPT_SUBST

parse_git_branch() {
  git_status="$(git status 2> /dev/null)"
  pattern="On branch ([^[:space:]]*)"
  if [[ ! ${git_status} =~ "(working (tree|directory) clean)" ]]; then
    state="*"
  fi

  if [[ ${git_status} =~ ${pattern} ]]; then
    branch=${match[1]}
    branch_cut=${branch:0:20}
    echo "(${branch}${state}) "
  fi
}

PROMPT='$(parse_git_branch)$ '

# Completions
autoload -U compinit && compinit
zmodload -i zsh/complist

fpath=(/usr/local/share/zsh-completions $fpath)

# useful git aliases
alias gb='git branch '
alias g='git '
alias gst='git status'
alias gco='git checkout '
alias gcmsg='git commit -m '

# node stuff
alias y='yarn'

# react stuff
alias y-t-all='yarn test --watchAll=false'

# better history
alias history='history 0'
alias h='history | grep'

# misc
alias c='clear'
alias down='docker-compose down'

# rbenv
if hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi

# Eternal history
# taken from https://unix.stackexchange.com/questions/273861/unlimited-history-in-zsh
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# workplace specific
alias run_doseme="cd && cd doseme/doseme-www/DoseMe && CATALYST_DEBUG=1 perl script/doseme_server.pl -r -p 4000"
alias run_sof="cd && cd doseme/smart-on-fhir-www && code . && yarn start"
alias s="sqitch"
alias "docker con"="docker container"
