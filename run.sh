echo "
████████╗██╗░░░██╗██████╗░██████╗░░█████╗░████████╗██╗░░░██╗██╗░░██╗
╚══██╔══╝██║░░░██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██║░░░██║╚██╗██╔╝
░░░██║░░░██║░░░██║██████╔╝██████╦╝██║░░██║░░░██║░░░██║░░░██║░╚███╔╝░
░░░██║░░░██║░░░██║██╔══██╗██╔══██╗██║░░██║░░░██║░░░██║░░░██║░██╔██╗░
░░░██║░░░╚██████╔╝██║░░██║██████╦╝╚█████╔╝░░░██║░░░╚██████╔╝██╔╝╚██╗
░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝╚═════╝░░╚════╝░░░░╚═╝░░░░╚═════╝░╚═╝░░╚═╝
░█████╗░██╗░░░██╗██████╗░██╗░█████╗░
██╔══██╗██║░░░██║██╔══██╗██║██╔══██╗
██║░░╚═╝██║░░░██║██████╦╝██║██║░░╚═╝
██║░░██╗██║░░░██║██╔══██╗██║██║░░██╗
╚█████╔╝╚██████╔╝██████╦╝██║╚█████╔╝
░╚════╝░░╚═════╝░╚═════╝░╚═╝░╚════╝░
░██████╗███████╗████████╗██╗░░░██╗██████╗░
██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗
╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝
░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░
██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░
╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░
░██████╗░█████╗░██████╗░██╗██████╗░████████╗
██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝
╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░
░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░
██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░
╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░"

sleep 2
echo "Completely remove Snaps. They're too slow for games."
sudo systemctl stop snapd
sudo apt remove --purge --assume-yes snapd gnome-software-plugin-snap
rm -rf ~/snap/
sudo rm -rf /var/cache/snapd/ 

echo "Add Repositories (to replace snaps)."
echo "deb [trusted=yes] https://turbotuxlinux.github.io/repo/ stable main" > /etc/apt/sources.list.d/turbotuxlinux.list
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo add-apt-repository ppa:thopiekar/openrgb -y
sudo add-apt-repository ppa:stk/dev -y
sudo add-apt-repository ppa:antimicrox/ppa -y
sudo add-apt-repository multiverse -y
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox
sudo apt update

echo "Install most things"
sudo apt install linux-headers-6.1.38turbotux linux-image-6.1.38turbotux linux-libc-6.1.38turbotux
sudo apt install firefox obs-studio kdenlive lutris openrgb steam antimicrox -y