# "Removes" the welcome message (sets it to nothing)
set fish_greeting

alias fp "flatpak"
alias fpu "flatpak update"
alias fpi "flatpak install -y"
alias fpr "flatpak uninstall -y"
alias fpc "flatpak uninstall -y --unused"
alias fps "flatpak search --columns=name:f,description:e,application:f,version,remotes"
alias fpl "flatpak list --columns=name:f,application:f,version,branch"
alias ls "exa -lF --no-time --no-permissions --group-directories-first"
alias la "exa -laF --no-time --no-permissions --group-directories-first"
alias lt "exa -lTF --no-time --no-permissions --group-directories-first"
alias lat "exa -laTF --no-time --no-permissions --group-directories-first"
alias cat bat

set -q ANDROID_HOME; or set -x ANDROID_HOME $HOME/.local/android-sdk
set -q ANDROID_SDK_ROOT; or set -x ANDROID_SDK_ROOT $HOME/.local/android-sdk
set -q CHROME_EXECUTABLE; or set -x CHROME_EXECUTABLE google-chrome-stable

set -l localBins "$HOME/.local/bin"
set -l nimbleBins "$HOME/.nimble/bin"
set -l flutterBins "$HOME/.local/flutter/bin"
set -l androidBins "$ANDROID_HOME/cmdline-tools/latest/bin"

set -ax PATH $localBins $nimbleBins $flutterBins $androidBins