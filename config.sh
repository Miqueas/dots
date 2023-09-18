echo -e "\e[1mSETTING TIME-ZONE\e[0m"
echo "> ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime"
ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
hwclock --systohc

echo -e "\e[1mCONFIGURING LOCALES\e[0m"
echo "> micro /etc/locale.gen /etc/locale.conf /etc/vconsole.conf /etc/hostname /etc/mkinitcpio.conf"
micro /etc/locale.gen /etc/locale.conf /etc/vconsole.conf /etc/hostname /etc/mkinitcpio.conf
locale-gen

echo -e "\e[1mGENERATING INITRD\e[0m"
echo "> mkinitcpio -P"
mkinitcpio -P

echo -e "\e[1mSETTING ROOT PASSWORD\e[0m"
echo "> passwd"
passwd

echo -e "\e[1mADDING USER JOSUE\e[0m"
echo "> useradd -s \$(which fish) -c \"Josué Martínez\" -mU josue"
useradd -s $(which fish) -c "Josué Martínez" -mU josue
usermod -aG wheel josue
passwd josue

echo -e "\e[1mEDITING USER PERMISSIONS\e[0m"
EDITOR=micro visudo

echo -e "\e[1mENABLING SERVICES\e[0m"
echo "> systemctl enable gdm"
echo "> systemctl enable NetworkManager"
echo "> systemctl enable bluetooth"
systemctl enable gdm
systemctl enable NetworkManager
systemctl enable bluetooth

echo -e "\e[1mINSTALLING BOOT LOADER\e[0m"
bootctl install
cat /etc/fstab > /boot/loader/entries/arch.conf
micro /boot/loader/entries/arch.conf /boot/loader/loader.conf

#echo -e "\e[1mCONFIGURING MIRRORS\e[0m"
#reflector -f 10 -l 10 -p https --score 10 --sort age --save /etc/pacman.d/mirrorlist
