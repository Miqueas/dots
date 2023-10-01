function install-luvit
  set -l litVersion   "3.8.5"
  set -l luviVersion  "2.14.0"
  set -l luvitVersion "2.18.1"

  echo "Installing Luvit $luvitVersion with Lit $litVersion and Luvi $luviVersion"

  set -l litUrl   https://lit.luvit.io/packages/luvit/lit/v$litVersion.zip
  set -l luviUrl  https://github.com/luvit/luvi/releases/download/v$luviVersion/luvi-regular-Linux_x86_64
  set -l luvitUrl https://lit.luvit.io/packages/luvit/luvit/v$luvitVersion.zip

  echo "Temporary changing to $HOME"
  cd $HOME

  echo "Downloading Lit and Luvit"
  wget -qO lit.zip   $litUrl
  wget -qO luvit.zip $luvitUrl
  
  __downloadLuvi $luviUrl

  echo "Building Lit with Luvi"
  ./luvi lit.zip -- make lit.zip ./lit ./luvi

  __downloadLuvi $luviUrl

  echo "Building Luvit with Lit"
  ./lit make luvit.zip ./luvit ./luvi

  __downloadLuvi $luviUrl

  if not [ -d $HOME/.local/bin ]
    mkdir -p $HOME/.local/bin
  end

  echo "Moving Lit, Luvi and Luvit to $HOME/.local/bin"
  mv lit luvi luvit $HOME/.local/bin
  echo "Cleaning up"
  rm lit.zip luvit.zip

  echo "Done!"
end

function __downloadLuvi
  echo "Downloading Luvi"
  wget -qO luvi $argv[1]
  echo "Changing permissions to Luvi"
  chmod +x luvi
end