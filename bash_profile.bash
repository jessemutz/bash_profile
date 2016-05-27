# Includes
# source `brew --prefix`/Library/Contributions/brew_bash_completion.sh

# Make sure anything added by homebrew takes precendence over OS X defaults.
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/ruby/1.9.3-p194/bin:$PATH"
#export PATH="/Applications/MAMP/bin/php5.3/bin:$PATH"

alias cbp="cordova build;cordova prepare"

# Quick CD to places
alias ll="ls -l"
alias la="ls -la"
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# Git Aliases and shortcuts.
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias co="git checkout"
alias cob="git checkout -b"
alias gpm="git push origin master"
alias gs="git status"
alias gsync="git pull && git push"
alias gi="~/bin/git-info.sh"
alias gl="git log --graph --oneline --all"
function gd
{
    if [[ `git diff |wc -l` -gt 0 ]]
    then
      git diff | /Applications/MacVim.app/Contents/MacOS/Vim -R -
    else
      echo "No changes since last commit."
    fi
}

# git remove deleted items in working directory
function grmwd {
  git status .|grep 'deleted:'|awk '{print $3}'|xargs git rm
}

# Drush 7.x clear caches
alias dcca="drush cc all"
alias clearall="drush cc all"
alias cleardrush="drush cc drush"
alias cleartheme="drush cc theme-registry"
alias clearmenu="drush cc menu"
alias clearcss="drush cc css-js"
alias clearblock="drush cc block"
alias clearmodule="drush cc module-list"
alias cleartheme="drush cc theme-list"
alias clearreg="drush cc registry"
alias cleartoken="drush cc token"
alias clearviews="drush cc views"

alias ct='ctags --langmap=php:.engine.inc.module.theme.php --php-kinds=cdfi --languages=php --recurse'
alias cts='ctags --langmap=php:.engine.inc.module.theme.php --php-kinds=cdfi --languages=php --recurse -f .tags'

alias cw='compass watch .'


# export DRUSH_PHP="/usr/local/opt/php55/bin/php"
export DRUSH_PHP="/usr/local/bin/php"


# alias pecl="/Applications/MAMP/bin/php/php5.5.10/bin/pecl"

# pretty colors in terminal :)
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias bin="sub ~/bin"
alias vadm="varnishadm -T:6082"

# Git editor
#export GIT_EDITOR="/usr/bin/vim"
#export GIT_EDITOR="/usr/local/bin/mate -w"
export GIT_EDITOR="subl -nw"
export EDITOR="subl -n"
#export EDITOR=/usr"/local/bin/mate"
alias sub="subl -n"

alias pc="pwd | pbcopy"
alias o="open ."

# Localhost and Local Development
alias ht="cd ~/htdocs"
alias hosts="sudo $EDITOR /etc/hosts"
alias vhost="$EDITOR ~/vhost.d"
alias aliases="$EDITOR ~/.drush/aliases.drushrc.php"
alias drushrc="$EDITOR ~/.drushrc.php"
alias rma="sudo apachectl restart | mysql.server restart"
alias rap="sudo apachectl restart"
alias rmy="mysql.server restart"

alias php55="brew unlink php56 | brew unlink php70 | brew link php55"
alias php56="brew unlink php55 | brew unlink php70 | brew link php56"
alias php70="brew unlink php55 | brew unlink php56 | brew link php70"

alias fdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

# Start, stop and restart solr easily.
function solr {
  solrpath="$HOME/Library/LaunchAgents/com.apache.solr.plist"
  case "$1" in
    "start" )
      cmd="launchctl load -w $solrpath"
      $cmd
      ;;
    "stop" )
      launchctl unload -w $solrpath
      ;;
    "restart" )
      launchctl unload -w $solrpath
      launchctl load -w $solrpath
      ;;
    * )
      /usr/bin/java -Djetty.home=$(brew --prefix solr)/libexec/example -Djetty.logs=/var/logs/solr -Dsolr.solr.home=$(brew --prefix solr)/libexec/example/multicore -jar $(brew --prefix solr)/libexec/example/start.jar
      ;;
  esac
}

# Prints working directory based on rules.
function wd {
  # Custom path strings.
  local pwd=$(pwd)
  local wd=${pwd##/Users/}
  # This gives us what we would normally see
  wd=${wd/$(whoami)/'~'}

  # Regex to grab the last 3 directories in the path.
  local mwd=`expr "$wd" : '.*/\(.*/.*/.*\)'`

  # As long as the regex returned something, print that.
  if [ -n "$mwd" ] ; then
    echo $mwd
  else
    echo $wd
  fi
}

# Sets custom prompt.
function prompt {
  local CYAN="\[\033[0;36m\]"
  local GREEN="\[\033[0;32m\]"
  local BLUE="\[\033[0;34m\]"
  local GRAY="\[\033[0;37m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"

  # Attempt to fix issue with TERM sometimes not being set...
  if [[ -z "$TERM" ]] ; then
    export TERM=xterm
  fi

  if [ "\$(type -t __git_ps1)" ] && [ "\$(type -t __drush_ps1)" ]; then
   export PS1="${CYAN}$MACHINE_NAME "${GREEN}' $(wd "(%s)")'${BLUE}' $(__git_ps1 "(%s)")'${LIGHT_BLUE}' $(__drush_ps1 "[%s]")'"${GRAY}$ \[$(tput sgr0)\]"
   fi
}
# Initialize our prompt.
prompt

# Port scanner.
scan() {
  if [[ -z $1 || -z $2 ]]; then
    echo "Usage: $0 <host> <port, ports, or port-range>"
    return
  fi

  local host=$1
  local ports=()
  case $2 in
    *-*)
      IFS=- read start end <<< "$2"
      for ((port=start; port <= end; port++)); do
        ports+=($port)
      done
      ;;
    *,*)
      IFS=, read -ra ports <<< "$2"
      ;;
    *)
      ports+=($2)
      ;;
  esac


  for port in "${ports[@]}"; do
    alarm 1 "echo >/dev/tcp/$host/$port" &&
      echo "port $port is open" ||
      echo "port $port is closed"
  done
}
alarm() {
  perl -e '
    eval {
      $SIG{ALRM} = sub { die };
      alarm shift;
      system(@ARGV);
    };
    if ($@) { exit 1 }
  ' "$@";
}
