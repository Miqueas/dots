# Removes the "welcome" thing
set fish_greeting

set -gx NIMPATH "$HOME/.nimble/bin"
set -gx SWIFTPATH "$HOME/.swift/usr/bin"
set -gx DISTROBOXPATH "$HOME/.distrobox/bin"
set -a PATH $NIMPATH $SWIFTPATH $DISTROBOXPATH

alias ls "ls -lhAF --color"