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

set -l localBins "$HOME/.local/bin"
set -l nimbleBins "$HOME/.nimble/bin"
set -l flutterBins "$HOME/.local/flutter/bin"
# set -x BUN_INSTALL "$HOME/.bun"

for p in $localBins "$localBins/gcm" $nimbleBins $flutterBins
  if not contains $p $PATH
    set -a PATH $p
  end
end

if not set -q CHROME_EXECUTABLE
  set -x CHROME_EXECUTABLE google-chrome-stable
end

#set -x PATH $PATH $LocalBins $NimbleBins $BUN_INSTALL/bin