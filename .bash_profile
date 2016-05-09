# source ~/bin/git-completion.bash
# source ~/.profile

###########################################################
# Include synced version of our bash profile.
#
SHARED_LOCATION=$HOME/Dropbox/DEV_TOOLS
BREW_DRUSH=$(brew --prefix drush)
source $SHARED_LOCATION/drush_completion.bash
source $SHARED_LOCATION/bash_profile.bash
source $SHARED_LOCATION/git-completion.bash
source $SHARED_LOCATION/git-prompt.sh
source $SHARED_LOCATION/drush.bashrc
#
# Place additions and overrides below
###########################################################

# Ruby
# SHARED bash profile uses 1.9.3. Set yours below.
RUBY_VERSON=2.2.0
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/ruby/$RUBY_VERSION\-p194/bin:$PATH"

# Quick CD to places
alias sites="cd ~/Sites"
alias design="cd ~/Design"
alias pending="cd ~/Design/pending_rejected"

# Git Aliases and shortcuts.
alias gad="git add . && git status"
alias gp="git pull"
alias tag="git tag"
alias gacss="git add css/; git add scss/"
alias gsp="git stash pop"
alias stash="git stash"

# Salt 'n Peppa
alias pushit="git push && afplay ~/Design/Design_Playbook/code/Shell/push_confirm.m4a"
alias pushitrg="git push origin master && afplay ~/Design/Design_Playbook/code/Shell/pushrg_confirm.m4a"
alias gituponthis="git init && afplay ~/Design/Design_Playbook/code/Shell/gitinit_confirm.m4a"

# Drush Remove Shield
alias rmshield="drush vset shield_pass '' && drush vset shield_user ''"

alias slbash="sub ~/.bash_profile"
alias sldrush="$HOME/.drush/aliases.drushrc.php"
alias sourcebash="source ~/.bash_profile"
alias sl="sub ."
alias sl..="sub ../"
alias sl..2="sub ../../"
alias sl..3="sub ../../../"

# Brew Update
alias brewup="brew update && brew upgrade"

# Virtual Box Startups
#
# To install a specific version of an ievm:
# curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS="7 9" bash
alias installie8="curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS=\"8\" bash"
alias installie9="curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS=\"9\" bash"
alias installie10="curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS=\"10\" bash"
alias installie11="curl -s https://raw.githubusercontent.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS=\"11\" bash"
alias ie6="VBoxManage startvm \"IE6 - WinXP\""
alias ie7="VBoxManage startvm \"IE7 - WinXP\""
alias ie8="VBoxManage startvm \"IE8 - WinXP\""
alias ie9="VBoxManage startvm \"IE9 - Win7\""
alias ie10="VBoxManage startvm \"IE10 - Win7\""
alias ie11="VBoxManage startvm \"IE11 - Win7\""

# Network Setup Manual Static IP Config
# networksetup -setmanual [networkservice] [ip] [subnet] [router]
#
# Set the DNS
# -setdnsservers networkservice dns1 [dns2]
#   75.75.75.75
#   75.75.75.76
# 
# Full Command
# networksetup -setmanual 4 74.92.216.58 255.255.255.248 74.92.216.62 && -setdnsservers networkservice 75.75.75.75 75.75.75.76alias setstaticmanual="networksetup -setmanual Wi-Fi 74.92.216.61 255.255.255.248 74.92.216.62 && networksetup -setdnsservers networkservice 75.75.75.75 75.75.75.76"
alias setstatic="networksetup -switchtolocation static"
alias setdynamic="networksetup -switchtolocation dynamic"
alias setautomatic="networksetup -switchtolocation automatic"

# YouTube Download
alias ytdl='youtube-dl -A -t --audio-quality 0 --max-quality url'
alias ytdlf="youtube-dl -F"
alias ytdlaac="youtube-dl -x --audio-format aac --audio-quality 0"
alias ytdlmp3="youtube-dl -x --audio-format mp3 --audio-quality 0"
alias ytdlm4a="youtube-dl -x --audio-format m4a --audio-quality 0"
alias ytdlaudio="youtube-dl -x --audio-format best --audio-quality 0"

alias apchrs="sudo apachectl restart"
alias apchst="sudo apachectl start"
alias apchstop="sudo apachectl stop"

# alias sanmail="drush sqlq \"UPDATE users SET mail = CONCAT('jesse+', --sanitize-email="user+%uid@localhost", '@clikfocus.com'))\""
alias sanmailcf="drush sqlsan --sanitize-email=\"jesse+user_%uid@clikfocus.com\" -y"
alias sanmail="drush sql-sanitize --sanitize-email=\"jesse+user_%uid@localhost\" -y"
alias sanpass="drush sql-sanitize --sanitize-password -y"
alias sandb="drush sql-sanitize --sanitize-password=\"PurpleNurple12!\" -y && drush sql-sanitize --sanitize-email=\"jesse+user_%uid@clikfocus.com\" -y"

# Drupal 8
alias cr="drush cr"
alias sex="drush cex"
alias sexy="drush cex -y"
alias cim="drush cim"

# Sets custom prompt and colors.
function prompt {
  local CYAN="\[\033[0;36m\]"
  local GREEN="\[\033[0;32m\]"
  local BLUE="\[\033[0;34m\]"
  local GRAY="\[\033[1;37m\]"
  local LIGHT_BLUE="\[\033[1;34m\]"
  local YELLOW="\[\033[0;33m\]"
  local RED="\[\033[0;31m\]"

  # Attempt to fix issue with TERM sometimes not being set...
  if [[ -z "$TERM" ]] ; then
    export TERM=xterm
  fi

  if [ "\$(type -t __git_ps1)" ] && [ "\$(type -t __drush_ps1)" ]; then
    # export PS1="${CYAN}jessemutz"${GREEN}' $(wd "(%s)")'${BLUE}' $(__git_ps1 "(%s)")'${LIGHT_BLUE}' $(__drush_ps1 "[%s]")'"${GRAY}$ \[$(tput sgr0)\]"
    export PS1="${BLUE}jessemutz"${GREEN}'$(wd "(%s)")'${CYAN}'$(__git_ps1 "(%s)")'${YELLOW}'$(__drush_ps1 "[%s]")'"${GRAY}$ \[$(tput sgr0)\]"
  fi
}
# Initialize our prompt.
prompt

# Sweet CD tool.
. /usr/local/z-master/z.sh

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
