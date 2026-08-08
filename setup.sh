# sudo nixos-rebuild switch --flake ~/nixos#laptop
# sudo nixos-rebuild switch --flake ~/nixos#desktop

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
flatpak override --user --filesystem=/run/user/$(id -u)/podman/podman.sock com.visualstudio.code
flatpak override --user --socket=podman com.visualstudio.code
systemctl --user enable --now podman.socket
