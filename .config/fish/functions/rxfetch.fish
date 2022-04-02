# Fish port of https://github.com/Mangeshrex/rxfetch

function rxfetch -d "System information fetcher"
  # Colors
  set -l c0       (set_color normal)
  set -l c1       (set_color -o magenta)
  set -l c2       (set_color -o green)
  set -l c3       (set_color -o blue)
  set -l c4       (set_color -o red)
  set -l c5       (set_color -o yellow)
  set -l c6       (set_color -o cyan)

  set -l template "

    $c1 os     $c0  $(_get_distro_name) $(uname -m)
    $c2 ker    $c0  $(uname -r)
    $c6 pkgs   $c0  $(_get_package_info)
    $c3 sh     $c0  $(basename $SHELL)
    $c5 ram    $c0  $(_get_mem)
    $c1 init   $c0  $(_get_init)
    $c2 de/wm  $c0  $(_get_de_wm)
    $c6 up     $c0  $(_get_uptime)
    $c5 disk   $c0  $(_get_storage_info)

"

  echo $template
end

# Get the init
function _get_init
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

# Get count of packages installed
function _get_pkg_count
  set -l package_managers "xbps-install" "apk" "apt" "pacman" "nix" "dnf" "rpm" "emerge"

  for package_manager in $package_managers
    if command -q $package_manager
      switch $package_manager
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
      end

      return
    end
  end

  echo 0
end

# Get count of flatpaks installed
function _get_flatpak_count
  if command -q flatpak
    flatpak list | wc -l
    return
  end

  echo 0
end

# Get package information formatted
function _get_package_info
  set -l pkg_count     (_get_pkg_count)
  set -l flatpak_count (_get_flatpak_count)

  if [ $pkg_count -ne 0 ]
    echo -n $pkg_count

    if [ $flatpak_count -ne 0 ]
      echo " ($flatpak_count flatpak)"
    end
  else if [ $flatpak_count -ne 0 ]
    echo "$flatpak_count flatpak"
  else
    echo "unknown"
  end
end

# Get distro name
function _get_distro_name
  set -l os (uname -o)
  if [ "$os" = "Android" ]
    echo 'Android'
  else
    awk -F '"' '/PRETTY_NAME/ { print $2 }' /etc/os-release
  end
end

# Get root partition space used
function _get_storage_info
  df -H --output=used,size / | awk 'NR == 2 { print $1" / "$2 }'
end

# Get Memory usage
function _get_mem
  free --mega | awk 'NR == 2 { print $3" / "$2" MB" }'
end

# Get uptime
function _get_uptime
  uptime -p | sed 's/up//'
end

# Get DE/WM
# Reference: https://github.com/unixporn/robbb/blob/master/fetcher.sh
function _get_de_wm
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