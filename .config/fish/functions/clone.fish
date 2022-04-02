# This may not work, i have some time without using this command

function clone -d "Custom wrapper around git clone"
  set -l opts "h/help" "f/from=" "g/gitlab" "m/method=" "e/git-ext"
  argparse -i $opts -- $argv

  # Show the help if -h or --help is used and exit
  if set -q _flag_h
    _help
    return
  end

  set -q _flag_m; and set -l Method $_flag_m; or set -l Method "git"
  set -q _flag_f; and set -l Domain $_flag_f; or set -l Domain "github.com"
  set -l GitFlags false
  set -l Repo
  set -l Dir
  set -l ArgLen (count $argv)

  if [ $ArgLen -eq 0 ]
    _err 1 "At least 1 argument expected"
    return
  else if [ $ArgLen -eq 1 ]
    set Repo $argv[1]
    set -e argv[1]
  else if [ $ArgLen -eq 2 ]
    set Repo $argv[1]

    if [ ! "( $argv[2] = - )" -o ! "( $argv[2] = -- )" ]
      set Dir $argv[2]
    end
  else if [ $ArgLen -ge 3 ]
    set Repo $argv[1]

    if [ ! "( $argv[2] = - )" -o ! "( $argv[2] = -- )" ]
      set Dir $argv[2]
    end

    if [ -z $Dir ]
      set -e argv[1..2]
    else
      set -e argv[1..3]
    end

    set GitFlags true
  else
    _err 2 "Can't parse arguments"
  end

  if set -q _flag_g
    set Method "https"
    set Domain "gitlab.com"
    set Repo "$Repo.git"
  else if set -q _flag_e
    set Repo "$Repo.git"
  end

  if [ $GitFlags ]
    if [ -z $Dir ]
      _clone $Method $Domain $Repo - $argv
      return
    else
      _clone $Method $Domain $Repo $Dir $argv
      return
    end
  else
    if [ -z $Dir ]
      _clone $Method $Domain $Repo -
      return
    else
      _clone $Method $Domain $Repo $Dir
      return
    end
  end
end

function _e
  echo -e $argv
end

function _cmd
  _e "\$" $argv
end

function _err
  set code $argv[1]
  set msg  $argv[2]
  _e "[Clone] Error: $msg"
  return $code
end

function _examples
  _e   "Examples:"
  _e   ""
  _cmd "clone denoland/deno"
  _cmd "clone denoland/deno deno-git # Clone in 'deno-git' folder"
  _cmd "clone denoland/deno -m https # Clone using 'git clone https://...'"
  _cmd "clone -g bitseater/meteo     # 'bitseater/meteo' is a Gitlab repository"
  _cmd
  _cmd "clone -f aur.archlinux.org -e yay-bin -m https"
  _cmd "clone -f code.qt.io -e qt/qtsvg"
end

function _help
  _e "Usage: clone [Options...] Repo [Dir]"
  _e ""
  _e "Options:"
  _e "  -h, --help            Show this help."
  _e "  -f, --from   <domain> Use 'domain' instead of 'github.com'."
  _e "  -g, --gitlab          Indicates that 'Repo' is a Gitlab repository."
  _e "  -m, --method <method> Use 'method' instead of 'git:' as connection method."
  _e "  -e, --git-ext         Append '.git' at the end of the git url (some repos"
  _e "                        need it)."
  _e ""
  _examples
  _e ""
  _e "Note: the Gitlab flag automatically set 'domain' and 'method' to work"
  _e "      properly with Gitlab repositories. Other flags are ignored."
  return 0
end

function _clone
  set m $argv[1] # Method
  set d $argv[2] # Domain
  set r $argv[3] # Repo
  set p          # Dir
  
  if [ ! "( $argv[4] = - )" -o ! "( $argv[4] = -- )" ]
    set p $argv[4]
  else
    set -e argv[4]
  end
  
  set f "$m://$d/$r" # Format

  if [ -z $p ]
    set -e argv[1..3]
    _e "Running: git clone $argv $f"
    git clone $argv "$f"
  else
    set -e argv[1..4]
    _e "Running: git clone $argv $f $p"
    git clone $argv "$f" "$p"
  end

  return
end