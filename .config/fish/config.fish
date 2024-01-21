# Removes the welcome message (sets it to nothing)
set fish_greeting

alias ls "eza -lF --no-time --no-permissions --group-directories-first"
alias la "eza -laF --no-time --no-permissions --group-directories-first"
alias lt "eza -lTF --no-time --no-permissions --group-directories-first"
alias lat "eza -laTF --no-time --no-permissions --group-directories-first"
alias cat bat

set -q ANDROID_HOME; or set -x ANDROID_HOME $HOME/.local/android-sdk
set -q ANDROID_SDK_ROOT; or set -x ANDROID_SDK_ROOT $HOME/.local/android-sdk
set -q CHROME_EXECUTABLE; or set -x CHROME_EXECUTABLE google-chrome-stable

set -l localBins "$HOME/.local/bin"
set -l nimbleBins "$HOME/.nimble/bin"
set -l flutterBins "$HOME/.local/flutter/bin"
set -l androidBins "$ANDROID_HOME/cmdline-tools/latest/bin"

set -ax PATH $localBins $nimbleBins $flutterBins $androidBins

function fp -d "Little flatpak wrapper" -w "flatpak"
  set -l action $argv[1]
  set -e argv[1]

  switch $action
    case i
      flatpak install -y $argv
    case r
      flatpak uninstall -y $argv
    case u
      flatpak update
    case s
      flatpak search --columns=name:f,description:e,application:f,version,remotes $argv
    case l
      flatpak list --columns=name:f,application:f,version,branch $argv
    case c
      flatpak uninstall -y --unused
    case '*'
      echo "Not implemented"
  end
end