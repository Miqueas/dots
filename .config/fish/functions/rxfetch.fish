# Fish port of https://github.com/Mangeshrex/rxfetch

function rxfetch -d "System information fetcher"
  # Colors
  set -l d  (set_color --dim)
  set -l b  (set_color --bold)
  set -l c0 (set_color normal)
  set -l c1 (set_color -o magenta)
  set -l c2 (set_color -o green)
  set -l c3 (set_color -o blue)
  set -l c4 (set_color -o red)
  set -l c5 (set_color -o yellow)
  set -l c6 (set_color -o cyan)

  set -l template "


$b              eeeeeee              $c0
$b          eeeee     eeeee          $c0
$b       eeee  eeeeeeeee  eeee       $c0
$b      eee  eee       ee   eee      $c0$c2 Distro   $c0$d➜$c0 $(getDistroName) ($(uname -m))
$b     ee   eee        ee     ee     $c0$c5 Kernel   $c0$d➜$c0 $(uname -r)
$b    ee   eee         ee      ee    $c0$c6 Packages $c0$d➜$c0 $(getPackageInfo)
$b    ee   ee         ee      eee    $c0$c4 Shell    $c0$d➜$c0 $(basename $SHELL)
$b    ee  eee       eee     eeeee    $c0$c1 RAM      $c0$d➜$c0 $(getMemoryInfo)
$b    ee   ee     eee      eee ee    $c0$c2 Init     $c0$d➜$c0 $(getInit)
$b    ee   eee  eeee     eee   ee    $c0$c5 DE/WM    $c0$d➜$c0 $(getDEWMInfo)
$b     ee  eeeeeee    eeeee   ee     $c0$c6 Uptime   $c0$d➜$c0 $(getUptime)
$b      eeeee  eeeeeeee     eee      $c0$c4 Storage  $c0$d➜$c0 $(getStorageInfo)
$b       eeee             eeee       $c0
$b          eeeee     eeeee          $c0
$b             eeeeeeeee             $c0


"

  printf $template "$c0$d" "$c0$d" "$c0$d" "$c0$d"
end

# Get the init
function getInit
  set -l os (uname -o)

  if [ "$os" = "Android" ]
    echo 'init.rc'
  else if pidof -q systemd
    echo 'systemd'
  else if [ -f '/sbin/openrc' ]
    echo 'openrc'
  else
    cut -d ' ' -f 1 /proc/1/comm
  end
end

# Get the system package manager
function getPackageManager
  set -l packageManagers "xbps-install" "apk" "apt" "pacman" "nix" "dnf" "rpm" "emerge"

  for packageManager in $packageManagers
    if command -q $packageManager
      echo $packageManager
      return
    end
  end

  echo "unknown"
end

# Get count of packages installed
function getPackageCount
  set -l packageManager (getPackageManager)

  switch $packageManager
    case xbps-install
      xbps-query -l | wc -l
    case apk
      apk search | wc -l
    case apt
      apt list --installed 2> /dev/null | wc -l
    case pacman
      pacman -Q | wc -l
    case nix
      nix-env -qa --installed '*' | wc -l
    case dnf
      dnf list installed | wc -l
    case rpm
      rpm -qa | wc -l
    case emerge
      qlist -I | wc -l
    case unknown
      echo 0
  end
end

# Get count of flatpaks installed
function getFlatpakCount
  if command -q flatpak
    flatpak list | wc -l
    return
  end

  echo 0
end

# Get package information formatted
function getPackageInfo
  set -l packageCount (getPackageCount)
  set -l flatpakCount (getFlatpakCount)
  set -l template "%s (%s)"

  if [ $packageCount -ne 0 ]
    printf $template $packageCount (getPackageManager)

    if [ $flatpakCount -ne 0 ]
      printf ", $template" $flatpakCount "flatpak"
    end
  else if [ $flatpakCount -ne 0 ]
    printf "$template" $flatpakCount "flatpak"
  else
    printf "unknown"
  end
end

# Get distro name
function getDistroName
  set -l os (uname -o)

  if [ "$os" = "Android" ]
    echo 'android'
  else
    string lower (awk -F '"' '/^PRETTY_NAME/ { print $2 }' /etc/os-release)
  end
end

# Get root partition space used
function getStorageInfo
  df -H --output=used,size / | awk 'NR == 2 { print $1" / "$2 }'
end

# Get Memory usage
function getMemoryInfo
  free --mega | awk 'NR == 2 { print $3" / "$2" MB" }'
end

# Get uptime
function getUptime
  uptime -p | sed 's/up\s//'
end

# Get DE/WM
# Reference: https://github.com/unixporn/robbb/blob/master/fetcher.sh
function getDEWMInfo
  set -l wm $XDG_CURRENT_DESKTOP
  [ $wm ]; or set wm $DESKTOP_SESSION

  # For most WMs
  if [ ! $wm ]; and [ "$DISPLAY" ]; and command -q xprop
    set -l id (xprop -root -notype _NET_SUPPORTING_WM_CHECK)
    set id (string match -r "0x.*" $id)
    set wm (xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t | grep '^_NET_WM_NAME' | cut -d\" -f 2)
  end

  # For non-EWMH WMs
  if [ ! $wm ]; or [ $wm = "LG3D" ]
    set wm (
      ps -e | grep -m 1 -o \
        -e "sway" \
        -e "kiwmi" \
        -e "wayfire" \
        -e "sowm" \
        -e "catwm" \
        -e "fvwm" \
        -e "dwm" \
        -e "2bwm" \
        -e "monsterwm" \
        -e "tinywm" \
        -e "xmonad"
    )
  end

  if [ $wm ]
    echo (string lower $wm)
  else
    echo "unknown"
  end
end
