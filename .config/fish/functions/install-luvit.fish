function install-luvit
  set -l litVersion   "3.8.5"
  set -l luviVersion  "2.14.0"
  set -l luvitVersion "2.18.1"

  set -l litUrl   https://lit.luvit.io/packages/luvit/lit/v$litVersion.zip
  set -l luviUrl  https://github.com/luvit/luvi/releases/download/v$luviVersion/luvi-regular-Linux_x86_64
  set -l luvitUrl https://lit.luvit.io/packages/luvit/luvit/v$luvitVersion.zip

  cd $HOME

  wget -qO lit.zip   $litUrl
  wget -qO luvit.zip $luvitUrl

  wget -qO luvi $luviUrl
  chmod +x luvi

  ./luvi lit.zip -- make lit.zip ./lit ./luvi

  wget -qO luvi $luviUrl
  chmod +x luvi

  ./lit make luvit.zip ./luvit ./luvi

  wget -qO luvi $luviUrl
  chmod +x luvi

  mv lit luvi luvit $HOME/.local/bin
  rm lit.zip luvit.zip
end