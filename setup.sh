flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.microsoft.Edge
flatpak install flathub com.brave.Browser
flatpak install flathub org.telegram.desktop
flatpak install flathub com.rtosta.zapzap
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.keepassxc.KeePassXC
flatpak install flathub org.ksnip.ksnip
# flatpak install flathub org.gnome.Boxes

# VS Code
flatpak install com.visualstudio.code
flatpak info com.visualstudio.code | grep Runtime
flatpak install flathub com.visualstudio.code.tool.podman # select version to match runtime from previous
flatpak override --user --filesystem=home com.visualstudio.code
flatpak override --user --talk-name=org.freedesktop.Flatpak com.visualstudio.code
flatpak override --user --env=DOCKER_HOST=unix:///run/user/1000/podman/podman.sock com.visualstudio.code
flatpak override --user --filesystem=xdg-run/podman com.visualstudio.code
flatpak override --user --socket=podman com.visualstudio.code
flatpak override --user --filesystem=/run/user/$(id -u)/podman/podman.sock com.visualstudio.code

podman build -t runner:local .
podman run --volume /home/sway/_git:/_git:Z -d runner:local --name agent
git init --bare ~/.dotfiles
dg remote add origin https://github.com/4c74356b41/dotfiles.git
mkdir downloads
rm -rf Desktop/ Documents/ Downloads/ Music/ Pictures/ Public/ Templates/ Videos/
xdg-user-dirs-update
systemctl --user mask xdg-user-dirs.service

podman volume create onedrive_conf
podman volume create onedrive_data
export ONEDRIVE_DATA_DIR="${HOME}/od"
export ONEDRIVE_UID=id -u
export ONEDRIVE_GID=id -g
mkdir -p ${ONEDRIVE_DATA_DIR}

podman run -it --name onedrive -v onedrive_conf:/onedrive/conf \
    --security-opt label=disable \
    -v "${ONEDRIVE_DATA_DIR}:/onedrive/data" \
    -e "ONEDRIVE_UID=${ONEDRIVE_UID}" \
    -e "ONEDRIVE_GID=${ONEDRIVE_GID}" \
    driveone/onedrive:edge

chown 525287:525287 /home/sway/od/docs/pwd.kdbx
sudo nano /var/home/sway/.local/share/containers/storage/volumes/onedrive_conf/_data/config
# need to do "y" in terminal if doing resync
# https://github.com/abraunegg/onedrive/blob/master/docs/docker.md#editing-the-running-configuration-and-using-a-config-file

sudo setfacl -R -d -m u:sway:rwx ~/od
sudo setfacl -R -d -m u:525287:rwx ~/od
sudo setfacl -R -m u:525287:rwx ~/od
sudo setfacl -R -m u:sway:rwx ~/od

sudo setfacl -R -d -m u:sway:rwx ~/_git
sudo setfacl -R -d -m u:525287:rwx ~/_git
sudo setfacl -R -m u:525287:rwx ~/_git
sudo setfacl -R -m u:sway:rwx ~/_git