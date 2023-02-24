# "Removes" the welcome message (sets it to nothing)
set fish_greeting

alias fp "flatpak"
alias fpu "flatpak update"
alias fpi "flatpak install -y"
alias fpr "flatpak uninstall -y"
alias fpc "flatpak uninstall -y --unused"
alias fps "flatpak search --columns=name:f,description:e,application:f,version,remotes"
alias fpl "flatpak list --columns=name:f,application:f,version,branch"
alias ls "exa -lF --no-time --no-permissions --no-user --group-directories-first"
alias la "exa -laF --no-time --no-permissions --no-user --group-directories-first"
alias lt "exa -lTF --no-time --no-permissions --no-user --group-directories-first"
alias lat "exa -laTF --no-time --no-permissions --no-user --group-directories-first"
alias cat bat

set -l LocalBins "$HOME/.local/bin"
set -l NimbleBins "$HOME/.nimble/bin"
# set -x BUN_INSTALL "$HOME/.bun"

for P in $LocalBins "$LocalBins/gcm" $NimbleBins
  if not contains $P $PATH
    set -a PATH $P
  end
end

#set -x PATH $PATH $LocalBins $NimbleBins $BUN_INSTALL/bin