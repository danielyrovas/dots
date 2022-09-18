#!/bin/bash

help_menu() {
	echo "Install script to automate installation of dependencies and configs"
	echo "Options:"
}

configure() {
	DISTRO="none"
	grep "Arch Linux" /etc/os-release &>/dev/null && DISTRO="archlinux"
	grep "Tumbleweed" /etc/os-release &>/dev/null && DISTRO="tumbleweed"

}

bootstrap() {
	case $DISTRO in
	"archlinux") pacstrap ;;
	"tumbleweed") tumbledry ;;
	*) echo "Linux distro not recognised" ;;
	esac
}

pacstrap() {
	echo "Installing packages for Arch Linux"

	# paru-bin https://aur.archlinux.org/paru-bin.git, makepkg -si
	# flatpak, xdg portals
	# Rust, rust nightly for EWW
}

tumbledry() {
	echo "Installing packages for Arch Linux"
}

# help_menu
configure
bootstrap
