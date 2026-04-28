#!/bin/bash

# Colores para output
R='\033[0;31m'
G='\033[0;32m'
Y='\033[1;33m'
NC='\033[0m'

#!/bin/bash

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

ruta="$HOME/bspwm_personal"

# Primera parte
echo -e "Ejecutando primera parte"
cd
git clone https://github.com/xJackSx/BSPWMparrot.git
cd BSPWMparrot
chmod +x install.sh
./install.sh

echo -e "${Y}Primera parte ejecutada"

# Segunda parte 
echo -e "Segunda parte en ejecucion${NC}"

cd $HOME/bspwm_personal

mkdir github
cd ~/github

# Instalando Wallpaper propios
rm -rf ~/Wallpaper/*
cp -v $ruta/Wallpaper/* ~/Wallpaper

# Copia de configuracion de .nanorc y .zshrc

rm -rf ~/.zshrc
cp -v $ruta/.zshrc ~/.zshrc
cp -v $ruta/.nanorc ~/.nanorc

# Script
sudo cp -v $ruta/scripts/autonmap /.local/bin/

sleep 5

# instalar snap y flatpak
sudo apt install snapd
sudo apt install flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# instslando lsd
sudo dpkg -i $ruta/lsd1.2.0.deb

# Instalando bat
sudo dpkg -i $ruta/bat0.26.1.deb

# Instalando xautolock, betterlock y tmux

cd ~/github
wget http://ftp.debian.org/debian/pool/main/x/xautolock/xautolock_2.2-8_amd64.deb
sudo dpkg -i xautolock_2.2-8_amd64.deb

#tmux
cd ~/github
git clone --single-branch https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

#betterlockscreen
git clone https://github.com/betterlockscreen/betterlockscreen 
cd betterlockscreen 
sudo ./install.sh

# Instalar i3lock imagemagick
sudo apt install i3lock imagemagick bc feh

# Instalar Obsidian thunderbird y thunar

sudo snap install obsidian --classic

sudo apt install thunderbird -y

sudo apt install thunar -y

# Install freetube
flatpak install flathub io.freetubeapp.FreeTube 
sudo flatpak repair

# Instalando de mas apt

sudo apt install arandr
sudo apt install blueman bluez bluez-tools pulseaudio-module-bluetooth -y

#Crontab para la actualizacion automatica de updates
sudo crontab -l > /tmp/micron 2>/dev/null
echo "*/30 * * * * /usr/bin/apt update >/dev/null 2>&1 && /usr/bin/apt list --upgradable 2>/dev/null | /bin/grep -E '^[^[:space:]]+[[:space:]]+' | /usr/bin/tee /home/n2o/.config/bin/updates-full.txt | /usr/bin/wc -l > /home/n2o/.config/bin/updates-count.txt" >> /tmp/micron
# Cargar el archivo
sudo crontab /tmp/micron
rm /tmp/micron

# Copiar los archivos a config
rm -rf $HOME/.config/{polybar,bin,bspwm,kitty,mpv,picom,rofi,sxhkd}
cp -av $ruta/Config/* ~/.config/

# Establecer permisos correctos
echo -e "${GREEN}🔑 Estableciendo permisos...${NC}"
chmod +x $HOME/.config/kitty/kitty.conf 2>/dev/null
chmod +x $HOME/.config/sxhkd/sxhkdrc 2>/dev/null
chmod +x $HOME/.config/bspwm/bspwmrc 2>/dev/null
chmod +x $HOME/.config/polybar/launch.sh 2>/dev/null
chmod +x $HOME/.config/bin/*.sh 2>/dev/null
chmod +x $HOME/.config/bspwm/*.sh 2>/dev/null
chmod +x $HOME/.config/bspwm/scripts/*.sh 2>/dev/null
chmod +x $HOME/.config/bspwm/scripts/Bspwm-ScratchPad 2>/dev/null
chmod +x $HOME/.config/bspwm/scripts/bspwm_resize 2>/dev/null
chmod +x $HOME/.config/kitty/kitty.conf 2>/dev/null
chmod +x $HOME/.config/polybar/config.sh 2>/dev/null
chmod +x $HOME/.config/polybar/scripts/*.sh 2>/dev/null
chmod +x $HOME/.config/polybar/scripts/updates/* 2>/dev/null
chmod +x $HOME/.config/rofi/applets/bin/*sh 2>/dev/null
chmod +x $HOME/.config/rofi/applets/shared/theme.bash 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-7/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-6/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-5/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-4/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-3/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-2/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/launchers/type-1/launcher.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-6/powermenu.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-5/powermenu.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-4/powermenu.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-3/powermenu.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-2/powermenu.sh 2>/dev/null
chmod +x $HOME/.config/rofi/powermenu/type-1/powermenu.sh 2>/dev/null

echo -e "${G}🔑 Permisos Establecidos Exitosamente${NC}"
sleep 3

# Limpiar

rm -rf ~/github
rm -rf $ruta

# Mensaje de Instalado
echo -e "${G}✨ Setup completado!${NC}"
echo -e "${Y}💡 Puedes cerrar sesion y entrar a bspwm${NC}"
