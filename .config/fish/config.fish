# "Removes" the welcome message (sets it to none)
set fish_greeting

set -l LocalBins "$HOME/.local/bin"
set -l NIMPATH "$HOME/.nimble/bin"
#set -gx DENO_INSTALL_ROOT "$HOME/.deno/bin"

for p in $LocalBins $NIMPATH
  if not contains $p $PATH
    set -a PATH $p
  end
end

alias fp "flatpak"
alias fpu "flatpak update"
alias fpi "flatpak install -y"
alias fpr "flatpak uninstall -y"
alias fpc "flatpak uninstall -y --unused"
alias fps "flatpak search --columns=name:f,description:e,application:f,version,remotes"
alias fpl "flatpak list --columns=name:f,application:f,version,branch"
alias ls "ls -lhF --color"
alias la "ls -lhAF --color"

# If "$XDG_DATA_HOME" doesn't exists, fallback to "$HOME/.local/share"
# (which is the usual value for the XDG variable)
set -l DataHome

if set -q $XDG_DATA_HOME
  set DataHome $XDG_DATA_HOME
else
  set DataHome "$HOME/.local/share"
end

# I have a problem with flatpak related to $XDG_DATA_DIRS, afaik, this
# is because I'm using fish as my shell instead of bash or something
# POSIX-compatible
#set -l --path DataDirs /usr/share/kde-settings/kde-profile/default/share /usr/local/share /usr/share
#set -gx --path XDG_DATA_DIRS $DataDirs "/var/lib/flatpak/exports/share" "$DataHome/flatpak/exports/share"

#set -l FlatpakBins "/var/lib/flatpak/exports/bin" "$DataHome/flatpak/exports/bin"

#for FDir in $FlatpakBins
#  if not contains $FDir $PATH
#    set -a PATH $FDir
#  end
#end
