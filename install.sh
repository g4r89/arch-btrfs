#!/bin/bash

dd if=/dev/zero of=/dev/sda bs=512 count=1 conv=notrunc
parted /dev/sda mktable gpt

mkfs.btrfs /dev/sda
mount /dev/sda /mnt
btrfs subvolume create /mnt/{root,home}
umount /mnt
mount -o subvol=root,compress=lzo,autodefrag /dev/sda /mnt
mkdir /mnt/home
mount -o subvol=home,compress=lzo,autodefrag /dev/sda /mnt/home

sed -ri '/yand|rol|aur/s/#//' /etc/pacman.d/mirrorlist

pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt ./chroot.sh
