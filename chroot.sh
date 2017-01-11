ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc --utc

sed -i '/#en_US.UTF/s/#//' /etc/locale.gen
locale-gen

echo g4xz > /etc/hostname

systemctl enable dhcpcd

useradd -m andrey
passwd andrey

pacman -Sy grub btrfs-progs
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

pacman -S xorg-server xorg-xinit i3-wm i3status dmenu chromium

exit
umount -R /mnt
