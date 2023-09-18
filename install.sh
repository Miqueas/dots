echo -e "\e[1mENTERING CFDISK\e[0m"
echo "> cfdisk /dev/sda"
cfdisk /dev/sda

echo -e "\e[1mFORMATING PARTITIONS\e[0m"
echo "> mkfs.ext4 /dev/sda2"
echo "> mkfs.fat -F 32 /dev/sda1"
mkfs.ext4 /dev/sda2
mkfs.fat -F 32 /dev/sda1

echo -e "\e[1mMOUNTING THE FILESYSTEM\e[0m"
echo "> mount /dev/sda2 /mnt"
echo "> mount /dev/sda1 /mnt/boot --mkdir"
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot --mkdir

echo -e "\e[1mRUNNING PACSTRAP\e[0m"
echo "> pacstrap -K /mnt base base-devel linux linux-firmware android-udev baobab bat blueprint-compiler bluez bluez-utils cantarell-fonts ccls cmake discord dmd dtools egl-wayland evince exfatprogs eza ffmpegthumbnailer file-roller fish flatpak flatpak-builder gdb gdm gimp git gnome-backgrounds gnome-boxes gnome-calculator gnome-console gnome-control-center gnome-font-viewer gnome-keyring gnome-online-accounts gnome-session gnome-shell gnome-system-monitor gnome-text-editor gnome-tweaks gobject-introspection gparted gst-libav gst-plugin-pipewire gst-plugin-va gst-plugins-bad gst-plugins-base gst-plugins-good gstreamer-vaapi gtk3-demos gtk4-demos gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-smb inetutils inkscape intel-gpu-tools intel-ucode ldc libadwaita-demos libheif libjxl libva-intel-driver libva-utils lua lua-sec lua-socket lua51 lua51-sec lua51-socket lua52 lua52-sec lua53 lua53-sec lua53-socket man-db mesa-amber mesa-utils meson micro mpc mpd mtools nautilus neofetch networkmanager ninja noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ntfs-3g obs-studio papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-pulse pkgfile plymouth qt5-wayland reflector sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf smartmontools telegram-desktop transmission-cli transmission-gtk tree ttf-cascadia-code-nerd unrar vala vulkan-intel vulkan-mesa-layers vulkan-tools wget wl-clipboard xdg-desktop-portal-gnome xdg-user-dirs yt-dlp"
pacstrap -K /mnt base base-devel linux linux-firmware android-udev baobab bat blueprint-compiler bluez bluez-utils cantarell-fonts ccls cmake discord dmd dtools egl-wayland evince exfatprogs eza ffmpegthumbnailer file-roller fish flatpak flatpak-builder gdb gdm gimp git gnome-backgrounds gnome-boxes gnome-calculator gnome-console gnome-control-center gnome-font-viewer gnome-keyring gnome-online-accounts gnome-session gnome-shell gnome-system-monitor gnome-text-editor gnome-tweaks gobject-introspection gparted gst-libav gst-plugin-pipewire gst-plugin-va gst-plugins-bad gst-plugins-base gst-plugins-good gstreamer-vaapi gtk3-demos gtk4-demos gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-smb inetutils inkscape intel-gpu-tools intel-ucode ldc libadwaita-demos libheif libjxl libva-intel-driver libva-utils lua lua-sec lua-socket lua51 lua51-sec lua51-socket lua52 lua52-sec lua53 lua53-sec lua53-socket man-db mesa-amber mesa-utils meson micro mpc mpd mtools nautilus neofetch networkmanager ninja noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ntfs-3g obs-studio papirus-icon-theme pipewire pipewire-alsa pipewire-audio pipewire-pulse pkgfile plymouth qt5-wayland reflector sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf smartmontools telegram-desktop transmission-cli transmission-gtk tree ttf-cascadia-code-nerd unrar vala vulkan-intel vulkan-mesa-layers vulkan-tools wget wl-clipboard xdg-desktop-portal-gnome xdg-user-dirs yt-dlp

echo -e "\e[1mGENERATING FSTAB\e[0m"
echo "> genfstab -U /mnt >> /mnt/etc/fstab"
echo "> micro /mnt/etc/fstab"
genfstab -U /mnt >> /mnt/etc/fstab
nano /mnt/etc/fstab

echo -e "\e[1mENTERING CHROOT\e[0m"
echo "> arch-chroot /mnt"
arch-chroot /mnt
