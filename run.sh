echo "
                         .=#%@@@@%*-                         
                       *@@@@@@@@@#%@*.                      
                      #@@@@@@@@@@#%@@@:                     
                     :@@@@@@@@@@@@@@@@@                     
                     =@%##@@@@%*++%@@@@=                    
                     =%:+:-@@+ ++-:@@@@+                    
                     =@-@@:#*+:@@% @@@@+                    
                     -@+===----==:=@@@@*                    
                     :@+===-----=++@@@@@                    
                      @#++====++===@@**@*                   
                     -@+:-+++==-.  :@@%@@*                  
                   .*@+  .:::..     .@@@@@%:                
                  =@@-               -@@@@@@+               
                .%@@+               . %@@@@@@@-             
               .@@@@-               ...+@@@@@@@+            
               #@@%.                    =@%%%@@@=           
              =@@@.                      #%@@%@@@.          
             -@%@-                       -@@@#@@@*          
            -@@@%                        :@@@%@@@@          
           :@@%%+                        :@@%@@@@@:         
           :%##%+                        =@@@@@%%@          
           -====#%=                    ===@@@@@@%=          
      ----=======*@@+.                .+==%@@@@#===         
     :============+@@@#:             .:+===+++==--=:        
     .+=============%@@%             :*+=-====-----=-:      
     .+==============+:            :*@%+=-----------==+.    
     =================+=:.     .-+%@@@#+=------===+++-.     
    .+++==============+#@@@@@@@@@@@@@@#+======++*=:         
       .:-==++++=====+**=-:::::--=+*#%#**++++*+:            
"
sleep 6
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

echo "remove ubuntu wallpapers"
sudo apt remove --purge ubuntu-wallpapers*

sudo apt update
sudo apt install software-properties-common apt-transport-https -y

echo "Add Repositories (to replace snaps)."
echo "deb [trusted=yes] https://turbotuxlinux.github.io/repo/ stable main" > /etc/apt/sources.list.d/turbotuxlinux.list
sudo add-apt-repository ppa:mozillateam/ppa -y
sudo add-apt-repository ppa:thopiekar/openrgb -y
sudo add-apt-repository ppa:stk/dev -y
sudo add-apt-repository ppa:libretro/stable -y
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
sudo apt install firefox obs-studio kdenlive lutris openrgb steam sc-controller minecraft-launcher retroarch flatpak vlc -y

echo "flatpak"
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install flathub hu.kramo.Cartridges 

echo "Customize logos, because why not?"
sudo cp /usr/share/plymouth/ubuntu-logo.png{,.bak}
sudo cp ./watermark.png /usr/share/plymouth/ubuntu-logo.png
sudo cp ./watermark.png /usr/share/plymouth/themes/spinner/watermark.png
sudo cp ./logo.png /usr/share/plymouth/themes/spinner/bgrt-fallback.png

echo "Pin stuff to dash"
echo '
[org.gnome.shell]
favorite-apps = "['firefox.desktop', 'org.gnome.Nautilus.desktop']"
' > /usr/share/glib-2.0/schemas/90_ubuntu-settings.gschema.override

echo "replace ubiquity slideshow"
sudo rm -r /usr/share/ubiquity-slideshow/slides
sudo cp -r ./slides /usr/share/ubiquity-slideshow/

echo "I think it's done"